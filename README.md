# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/). Generic setup for macOS (and Linux where noted); no machine-specific paths.

## Install (new machine)

```bash
# Clone this repo, then run the installer (installs chezmoi if needed and applies dotfiles)
git clone <this-repo-url> ~/dotfiles
~/dotfiles/install.sh
```

Or with chezmoi already installed:

```bash
chezmoi init --apply <this-repo-url>
```

## What’s included

- **Shell:** bash and zsh config, shared `~/.profile` and `~/.profile.d/` (PATH, editor, languages, etc.)
- **Homebrew (macOS):** Declarative list in `.chezmoidata/packages.yaml`; `chezmoi apply` installs/upgrades those packages
- **Neovim:** Config and plugins (Packer)
- **Vim:** Config and plugins (vim-plug; installed automatically on first apply)
- **Git:** Aliases and defaults (no `user.name`/`user.email` — set those locally)
- **tmux, fzf, ripgrep, direnv, starship:** Config as present in the repo

## Manual steps after first apply

Do these once after `chezmoi apply` (or `install.sh`) on a new machine:

| Step | Command | Why |
|------|---------|-----|
| **Neovim plugins** | Open `nvim`, then run `:PackerSync` | Packer generates config and installs plugins; not applied from the repo. |
| **Vim plugins** | Open `vim`, then run `:PlugInstall` | vim-plug is installed by a run_once script; plugins are installed on first `:PlugInstall`. |

## Optional one-time setup

- **Git identity:** Set your name and email (not in the repo):
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "you@company.com"
  ```
- **GITHUB_USER:** If you use it, either:
  - Create `~/.config/github_user` with your GitHub username (one line), or
  - Set `GITHUB_USER` in `~/.bash_additions` or `~/.zshenv.local`
- **Machine-specific overrides:** Optional files (not in the repo):
  - `~/.bash_additions` — sourced by bash
  - `~/.zshenv.local` — sourced by zsh

## Optional / situational

- **Bazel / arc:** Some aliases (e.g. `bbt`, `gpr`, `flaky`) assume Bazel and (for `gpr`) `arc`. Safe to ignore if you don’t use them.
- **Android:** `logcat`, `ss`, `pklist`, `atext` in bash assume `adb`; harmless if `adb` isn’t installed.
- **Neovim:** See [Manual steps after first apply](#manual-steps-after-first-apply) — run `:PackerSync` once.

## Updating

```bash
cd ~/dotfiles   # or your clone
git pull
chezmoi apply
```
