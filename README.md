# My dotfiles

An attempt at increasing the portability of my dotfiles, configs, and scripts.

`zsh` is now the default shell on MacOS.
To change back to `bash`: Terminal > Settings > Shell open with: `/bin/bash`.

To set iterm shell to bash: Profiles > Command > Custom Shell: `/bin/bash`

## Smoke test
Run `./smoke-test` to verify the shell modules load and the key failure paths still behave safely (does not write to `$HOME`).

## Install / Pull plans
Use `./install-shell-profile --list` (or `--plan`) to see which files would be symlinked into `$HOME` without changing anything.
Use `./pull-shell-profile --list` (or `--plan`) to see which files would be copied back into `src/` without changing anything.
Use `--profile all` with `install-shell-profile`, `pull-shell-profile`, or `refresh` to operate on every profile directory under `src/bash/profiles/`.

## Shell setup
The managed shell profiles currently assume this repo lives at `/Users/mattriley/Home/Code/my-dotfiles`.

They set:
- `DOTFILES_DIR=/Users/mattriley/Home/Code/my-dotfiles`
- `BASH_MODULES=$DOTFILES_DIR/src/bash/modules`

If that repo path changes, update [src/bash/profiles/default/.bashrc](/Users/mattriley/Home/Code/my-dotfiles/src/bash/profiles/default/.bashrc) so both bash and zsh load the shared modules from the correct location.

## CI
GitHub Actions runs `shellcheck` and `./smoke-test` on every push and pull request.

## Principles
Use these as the default guide for future changes so the repo stays internally consistent.

- Prefer explicit configuration over discovery. If a path or dependency matters, set it directly instead of inferring it from fragile filesystem assumptions.
- Keep non-interactive shells quiet. Startup files should avoid decorative output or warnings in scripted contexts unless something is genuinely broken.
- Fail safely when optional tools are missing. Shell helpers should return cleanly when commands like `nodenv`, `nvm`, `code`, or `osascript` are unavailable.
- Treat interactive and non-interactive shells differently on purpose. Prompts, banners, and interactive UX belong only in interactive sessions.
- Avoid destructive defaults. Helpers should prefer no-op or clear failure over aggressive behavior when inputs are missing or ambiguous.
- Make empty cases valid. Commands that scan directories or profiles should handle “nothing found” without noisy glob or `find` errors.
- Prefer explicit contracts and shared boundaries. Use environment variables and clear helper/function boundaries rather than hidden coupling, duplicated control flow, or deep auto-discovery.
- Prefer thin entrypoints and shared helpers. Keep top-level scripts and shell profiles focused on orchestration; move repeated logic into shared helper files.
- Keep modules standalone when practical. If a module depends on shared helper code, it should still be safe to source on its own.
- Minimize incidental dependencies. Prefer built-in shell features and standard utilities over extra tools unless they materially improve correctness or keep the code simpler.
- Share behavior before adding variants. If bash and zsh, or install and pull, need the same logic, consolidate it before making shell-specific tweaks.
- Preserve behavior while simplifying structure. Broad refactors should reduce duplication without changing user-visible output unless that change is intentional and tested.
- Refactor toward declarative tests. As coverage grows, prefer reusable test helpers over long procedural test blocks.
- Back changes with checks. If a bug or regression matters, add or extend `smoke-test` so the behavior is enforced automatically.
- Keep shell code lint-clean. Treat `shellcheck` warnings as design feedback, not just formatting noise.

## Code Conventions
- Prefer small shell functions with one clear responsibility.
- Keep top-level scripts readable from top to bottom: parse args, define helpers, run the main flow.
- Name shared helpers by domain to make ownership obvious: `dotfiles.*`, `node.*`, `util.*`, `prompt.*`, and so on.
- When a module depends on another local helper, source it defensively so the module can still be used on its own.
- Quote variable expansions unless unquoted behavior is explicitly required.
- Prefer early returns over deep nesting in shell functions.
- Keep user-facing output stable and intentional, especially for `--dry-run`, `--list`, and smoke-test messages.
- Prefer adding a shared helper over copying a block for the third time.
- Keep test assertions direct and high-signal: check the externally observable behavior, not incidental implementation details.

## Code Style
- Use 4-space indentation in shell scripts; do not mix tabs and spaces.
- Prefer multi-line functions and control flow over compressed one-liners when the logic is more than trivial.
- Keep blank lines meaningful: separate setup, validation, main logic, and cleanup.
- Prefer local variables inside functions unless the value is intentionally part of the shared shell environment.
- Use descriptive variable names for temporary values when they carry meaning beyond a single command.
- Keep comments short and operational. Explain why something exists or what edge case is being handled, not what the syntax already says.
- Prefer consistent guard patterns such as `command || return`, `check || exit 1`, and explicit `if` blocks for user-facing failures.
- Keep output strings and error messages sentence-like and consistent so tests and CLI behavior stay predictable.

### Statement Style
- Declare functions as `function name { ... }`.
- Do not use trailing `()` in function declarations.
- Put the opening `{` on the same line as the function name.
- Put the closing `}` on its own line.
- Prefer `local` for function-scoped variables.
- Prefer `$(...)` over backticks for command substitution.
- Prefer `[ ... ]` for simple tests and `[[ ... ]]` only when pattern matching or regex is actually needed.
- Use `return` inside functions and `exit` only in true script entrypoints.
- Prefer `printf` when output format matters; use `echo` for simple status messages.
- Keep one command per line unless a short guard form such as `check || return 1` is clearly simpler.
- Prefer explicit multi-line `if` blocks when the branch has more than one meaningful step.
