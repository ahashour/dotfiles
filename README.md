# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/). Generic setup for macOS (and Linux where noted); no machine-specific paths.

---

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

---

## Manual steps after first apply

Do these **once** after `chezmoi apply` (or `install.sh`) on a new machine:

| Step | Command | Why |
|------|---------|-----|
| **Neovim plugins** | Open `nvim`, then run `:PackerSync` | Packer generates config and installs plugins; not applied from the repo. |
| **Vim plugins** | Open `vim`, then run `:PlugInstall` | vim-plug is installed by a run_once script; plugins are installed on first `:PlugInstall`. |

---

## How the setup works

- **Profile:** `~/.profile` is the single entry point for environment and PATH. It sources everything under `~/.profile.d/` (hostname, locale, homebrew, editor, languages, etc.). Both bash and zsh use this so PATH and env vars are consistent.
- **Shells:** Bash uses `~/.bash_profile` (then `~/.profile` and `~/.bashrc`). Zsh uses `~/.zprofile` (then `~/.profile`) and `~/.zshrc` (which sources `~/.zsh/rc.d/*` and `~/.aliases`). So `~/.aliases` is shared; bash-specific stuff lives in `~/.bash_profile`, zsh-specific in `~/.zsh/rc.d/`.
- **Editor:** `EDITOR` is set to `nvim` if available, else `vim`, in `~/.profile.d/editor`. Git and other tools use this.
- **Homebrew (macOS):** Packages are declared in `.chezmoidata/packages.yaml`. A run_onchange script runs `brew bundle` and `brew upgrade` when that list or the script changes, so installs and upgrades are automatic.

---

## What’s included (overview)

| Area | Details |
|------|---------|
| **Shell** | Bash + Zsh, shared `~/.profile` and `~/.profile.d/`, `~/.aliases` |
| **Homebrew (macOS)** | Declarative list in `.chezmoidata/packages.yaml`; install/upgrade on apply |
| **Vim** | `~/.vimrc` + vim-plug, PaperColor theme, NERDTree, CtrlP, fzf, fugitive, etc. |
| **Neovim** | `~/.config/nvim/` with Lua config, Packer, LSP, Telescope, Git integration |
| **Git** | Aliases and defaults in `~/.gitconfig` (no `user.name`/`user.email` — set locally) |
| **tmux** | `~/.tmux.conf`: hjkl pane nav, `\` / `-` splits, status bar (molokai), fastcopy |
| **fzf** | Fuzzy finder; `Ctrl+T` (files), `Alt+C` (dirs); uses ripgrep when available |
| **ripgrep** | `RIPGREP_CONFIG_PATH=~/.config/ripgrep/rc` |
| **direnv** | Hook in bash and zsh for per-directory env |
| **Starship** | Prompt (config in `~/.config/starship.toml`); used if available |
| **fasd** | Quick jump to recent/freq dirs (when installed) |
| **Languages** | PATH/setup for Go, Python, Ruby, Rust, Node (nvm), Haskell in `~/.profile.d/` |

---

## Functionality and shortcuts

### Shell (shared aliases in `~/.aliases`)

- **Listing:** `l`, `ll`, `la`, `lla` → `ls` variants; `tree` → `exa --tree` if exa is installed.
- **Editor:** If `EDITOR=nvim`, `vi`/`vim`/`vimdiff` point to nvim.
- **Git:** `g` → `git`; `gs` → short status; `gl` → log oneline; `glp` → graph log; `gclean` → delete merged branches.
- **Tmux:** `ta <name>` attach to session; `tn <name>` new session.
- **Go:** `gotestc` → run tests and open coverage in browser.
- **Port forward:** `port_forward <port> <host>`; `devpod_port_forward <port>` (uses `$DEVPOD`).
- **Bazel (optional):** `bbt`, `gbt`, `gpr`, `flaky` (see [Optional / situational](#optional--situational)).

### Bash-only (in `~/.bash_profile`)

- **History:** `HISTSIZE`/`HISTFILESIZE` 100k; `hsync()` to append and reload history.
- **Git:** `gl [n]`, `top_committers [n]`, `grp <ref>` (rev-parse to pbcopy), `doreplace`, `gclean`, `clearbak`.
- **Go:** `gt <test>` (go test -v -race -run), `webgodocs` (godoc server).
- **Bazel:** `brules` (query rules).
- **Android (optional):** `logcat`, `ss`, `pklist`, `atext`.
- **Completions:** Git and Bazel completion when on macOS with Homebrew.

### Zsh

- **Vi mode** in `~/.zsh/rc.d/editor`: `Ctrl+A`/`Ctrl+E` line, `Ctrl+K` kill line, `Esc` then `v` to edit line in editor.
- **Dir:** `autocd`, `autopushd`, `pushd_ignoredups`.
- **Prompt:** Starship if available, else fallback; “Presentation” iTerm profile uses a minimal prompt.
- **fzf:** Uses `rg --files` when ripgrep is available.

### Vim (`~/.vimrc`)

- **Leader:** `<Space>`.
- **Save/quit:** `<leader>w` write, `<leader>q` quit.
- **Config:** `<leader>\` vsplit vimrc, `<leader>-` split vimrc, `<leader>sv` source vimrc.
- **Dir browser:** `<leader>u` open current file’s dir in vsplit; `:Dir` command.
- **Spell:** `<leader>ss` set spell, `<leader>ns` nospell.
- **NERDTree:** `<leader>t` focus, `<leader>r` find current file, `Ctrl+N` toggle (custom).
- **Rust:** `<leader>ts` run RustTest.
- **Bazel:** Buildifier run on save for `*.star`, `*.bzl`, `*.bazel`.
- **Theme:** PaperColor (dark).

### Neovim (`~/.config/nvim/`)

- **Leader:** `<Space>`.
- **Save/quit:** `<leader>w` write, `<leader>q` quit.
- **Config:** `<leader>\` vsplit config, `<leader>-` split config, `<leader>sv` source config.
- **Spell:** `<leader>ss` spell on, `<leader>ns` spell off.
- **NERDTree:** `<leader>t` focus.
- **Telescope:** `<leader>tf` find files, `<leader>tg` live grep, `<leader>th` help tags, `<leader>tb` git branches, `<leader>tr` resume.
- **LSP:** `gd` go to definition, `K` hover, `grr` rename, `grf` references.
- **Git (fugitive):** `<leader>ggu` stage, `<leader>gga` amend, `<leader>ggc` commit, `<leader>ggrc` rebase continue, `<leader>ad` diff (arc), `<leader>ud` diff undo.
- **Go:** `<leader>gi` imports, `<leader>gf` format, `<leader>gb` build, `<leader>gd` def, `<leader>ge` test.
- **Comment:** `<leader>/` toggle (normal/visual).
- **Terminal:** `Ctrl+\` then `Ctrl+{h,j,k,l}` to move from terminal to other windows.

### Tmux (`~/.tmux.conf`)

- **Panes:** `j`/`k`/`h`/`l` select pane (no prefix).
- **Splits:** `\` vertical, `-` horizontal (open in current path).
- **Reload config:** `Ctrl+B` then `Ctrl+R`.
- **Mouse:** on; copy via tmux-fastcopy (Phabricator D-ids and Bazel labels have regex support).
- **Status:** Molokai-style (`~/.tmux-molokai.conf`).

---

## Optional one-time setup

- **Git identity:** Set your name and email (not in the repo):
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "you@company.com"
  ```
- **GITHUB_USER:** If you use it, either:
  - Create `~/.config/github_user` with your GitHub username (one line), or
  - Set `GITHUB_USER` in `~/.bash_additions` or `~/.zshenv.local`
- **Machine-specific overrides** (not in the repo):
  - `~/.bash_additions` — sourced by bash
  - `~/.zshenv.local` — sourced by zsh

---

## Optional / situational

- **Bazel / arc:** Aliases `bbt`, `gbt`, `gpr`, `flaky` assume Bazel; `gpr` also uses `arc`. Safe to ignore if you don’t use them.
- **Android:** Bash aliases `logcat`, `ss`, `pklist`, `atext` use `adb`; harmless if `adb` isn’t installed.
- **exa:** If installed, `ls` and `tree` in `~/.aliases` use exa.
- **Netlify:** PATH for Netlify CLI helper when `~/.config/netlify/helper/bin` exists.
- **Google Cloud SDK:** Sourced from `$HOME/google-cloud-sdk/` when present (bash).

---

## Updating

```bash
cd ~/dotfiles   # or your clone
git pull
chezmoi apply
```
