# My dotfiles

Portable shell profiles, helper modules, and small workflow scripts for this machine.

## Overview
- Default shell: `zsh`
- Repository path assumed by the managed profiles: `/Users/mattriley/Home/Code/my-dotfiles`
- Shared module root: `$DOTFILES_DIR/src/bash/modules`

To switch Terminal back to bash on macOS:
- Terminal > Settings > Shell open with: `/bin/bash`

To switch iTerm back to bash:
- Profiles > Command > Custom Shell: `/bin/bash`

## Usage
### Dependency bootstrap
Run `./install-dependencies` to install the small set of external tools this repo expects for validation and maintenance. The script is rerunnable and skips packages that are already installed.

### Validation
Run `./smoke-test` to verify that the shell modules load and that key failure paths still behave safely. It does not write to `$HOME`.

### Profile planning
Use `./install-shell-profile --list` or `./install-shell-profile --plan` to see which files would be symlinked into `$HOME`.

Use `./pull-shell-profile --list` or `./pull-shell-profile --plan` to see which files would be copied back into `src/`.

Use `--profile all` with `install-shell-profile`, `pull-shell-profile`, or `refresh` to operate on every profile directory under `src/bash/profiles/`.

## Configuration
The managed profiles currently set:
- `DOTFILES_DIR=/Users/mattriley/Home/Code/my-dotfiles`
- `BASH_MODULES=$DOTFILES_DIR/src/bash/modules`
- `.bash_profile` requires `.bashrc`; bash initialization lives in `.bashrc`, while `.bash_profile` is only the login-shell wrapper
- `.zprofile` requires `.zshrc`; zsh initialization lives in `.zshrc`, while `.zprofile` is only the login-shell wrapper

If the repository path changes, update [src/bash/profiles/default/.bashrc](/Users/mattriley/Home/Code/my-dotfiles/src/bash/profiles/default/.bashrc) so both bash and zsh load shared modules from the correct location.

## Quality Checks
GitHub Actions runs:
- `shellcheck`
- shell syntax validation with `bash -n` and `zsh -n`
- `./smoke-test`

These checks run on every push and pull request.

## Design Principles
- Prefer explicit configuration over discovery. If a path or dependency matters, set it directly instead of inferring it from fragile filesystem assumptions.
- Keep non-interactive shells quiet. Startup files should avoid decorative output or warnings in scripted contexts unless something is genuinely broken.
- Treat interactive and non-interactive shells differently on purpose. Prompts, banners, and interactive UX belong only in interactive sessions.
- Fail safely when optional tools are missing. Shell helpers should return cleanly when commands such as `nodenv`, `nvm`, `code`, or `osascript` are unavailable.
- Avoid destructive defaults. Helpers should prefer a no-op or clear failure over aggressive behavior when inputs are missing or ambiguous.
- Make empty cases valid. Commands that scan directories or profiles should handle “nothing found” without noisy glob or `find` errors.
- Prefer explicit contracts and shared boundaries. Use environment variables and clear helper/function boundaries rather than hidden coupling, duplicated control flow, or deep auto-discovery.
- Prefer thin entrypoints and shared helpers. Keep top-level scripts and shell profiles focused on orchestration; move repeated logic into shared helper files.
- Load module directories alphabetically as ordered sets. Shared helpers should load before dependent files by filename, rather than each file self-sourcing its own prerequisites.
- Minimize incidental dependencies. Prefer built-in shell features and standard utilities over extra tools unless they materially improve correctness or keep the code simpler.
- Share behavior before adding variants. If bash and zsh, or install and pull, need the same logic, consolidate it before making shell-specific tweaks.
- Preserve behavior while simplifying structure. Broad refactors should reduce duplication without changing user-visible output unless that change is intentional and tested.
- Refactor toward declarative tests. As coverage grows, prefer reusable test helpers over long procedural test blocks.
- Back changes with checks. If a bug or regression matters, add or extend `smoke-test` so the behavior is enforced automatically.
- Keep shell code lint-clean. Treat `shellcheck` warnings as design feedback, not just formatting noise.

## Coding Standards
### General conventions
- Prefer small shell functions with one clear responsibility.
- Keep top-level scripts readable from top to bottom: parse arguments, define helpers, run the main flow.
- Name shared helpers by domain to make ownership obvious: `dotfiles.*`, `node.*`, `util.*`, `prompt.*`, and so on.
- Use file naming to express load order inside module directories. The loader sources files alphabetically, so shared helpers should use names such as `00-common.sh`.
- Guard shared-helper usage at bootstrap boundaries only. It is reasonable to check whether a shared file or bootstrap helper has loaded before first use in startup code.
- Do not scatter repeated function-existence checks through normal control flow. Once a shared helper file is loaded, call its functions directly and treat missing helpers as a structural error.
- Keep dependency assumptions explicit. If a file depends on shared module helpers, rely on documented loader order rather than hidden self-sourcing.
- Prefer early returns over deep nesting in shell functions.
- Keep user-facing output stable and intentional, especially for `--dry-run`, `--list`, and `smoke-test` messages.
- Prefer adding a shared helper over copying a block for the third time.
- Keep test assertions direct and high-signal. Check externally observable behavior, not incidental implementation details.

### Formatting and style
- Use 4-space indentation in shell scripts. Do not mix tabs and spaces.
- Prefer multi-line functions and control flow over compressed one-liners when the logic is more than trivial.
- Keep blank lines meaningful. Separate setup, validation, main logic, and cleanup.
- Prefer local variables inside functions unless the value is intentionally part of the shared shell environment.
- Use descriptive variable names for temporary values when they carry meaning beyond a single command.
- Keep comments short and operational. Explain why something exists or what edge case is being handled, not what the syntax already says.
- Prefer consistent guard patterns such as `command || return`, `check || exit 1`, and explicit `if` blocks for user-facing failures.
- Keep output strings and error messages sentence-like and consistent so tests and CLI behavior stay predictable.

### Statement style
- Declare functions as `function name { ... }`.
- Do not use trailing `()` in function declarations.
- Put the opening `{` on the same line as the function name.
- Put the closing `}` on its own line.
- Prefer `local` for function-scoped variables.
- Prefer `$(...)` over backticks for command substitution.
- Prefer `[ ... ]` for simple tests and `[[ ... ]]` only when pattern matching or regex is actually needed.
- Put spaces inside test brackets: `[ -n "$value" ]`, not `[-n "$value"]`.
- Prefer `${var:-default}` or `${var:=default}` when a simple parameter default is enough.
- Quote parameter expansions in assignments and command arguments unless unquoted behavior is required.
- Use `return` inside functions and `exit` only in true script entrypoints.
- Prefer `printf` when output format matters; use `echo` for simple status messages.
- Keep one command per line unless a short guard form such as `check || return 1` is clearly simpler.
- Prefer explicit multi-line `if` blocks when the branch has more than one meaningful step.
- Prefer `case` over long `if` / `elif` chains for argument parsing and enum-like branching.
- Use `read -r` by default.
- Scope `IFS` changes as narrowly as possible.
- Prefer arrays over word-splitting strings when representing lists of paths or arguments.
- Prefer null-delimited loops for file paths when using `find`.
- Quote here-doc delimiters when interpolation is not intended, for example `<<'EOF'`.
- Guard optional `source` calls with `[ -f ... ]` or a shared helper so startup stays quiet.
- Prefer shared helpers for repeated shell mechanics such as command checks or path mutation.
- In module directories, rely on alphabetical load order and ordered filenames such as `00-common.sh` rather than per-file dependency guards.
