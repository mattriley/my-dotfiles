# My dotfiles

An attempt at increasing the portability of my dotfiles, configs, and scripts.

`zsh` is now the default shell on MacOS.
To change back to `bash`: Terminal > Settings > Shell open with: `/bin/bash`.

To set iterm shell to bash: Profiles > Command > Custom Shell: `/bin/bash`

## Smoke test
Run `./smoke-test` to verify the bash module files load correctly (does not write to `$HOME`).

## Install / Pull plans
Use `./install-shell-profile --list` (or `--plan`) to see which files would be symlinked into `$HOME` without changing anything.
Use `./pull-shell-profile --list` (or `--plan`) to see which files would be copied back into `src/` without changing anything.
