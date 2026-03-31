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
- Prefer simple shell contracts. Use environment variables and clear function boundaries rather than hidden coupling or deep auto-discovery.
- Back changes with checks. If a bug or regression matters, add or extend `smoke-test` so the behavior is enforced automatically.
- Keep shell code lint-clean. Treat `shellcheck` warnings as design feedback, not just formatting noise.
