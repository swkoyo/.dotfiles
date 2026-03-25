# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a cross-platform dotfiles repository managed with **GNU Stow**, targeting Arch Linux (primary) and macOS. Configurations span ~20 tools including Neovim, Tmux, Zsh, Hyprland, AeroSpace, and various terminal emulators.

## Dotfiles Management

**Stow** creates symlinks from each tool's directory to `$HOME`, mirroring the home directory structure:
- `ghostty/.config/ghostty/config` → `~/.config/ghostty/config`
- `bin/.local/scripts/tmux-sessionizer` → `~/.local/scripts/tmux-sessionizer`

Stow is active — editing files in this repo **directly modifies** the live config via symlinks. Changes take effect immediately (or after restarting the relevant tool).

### Install Scripts

- `./install` — Generic installer; takes `STOW_FOLDERS` env var (comma-separated list of directories to stow)
- `./archlinux` — Arch Linux install (default stow: `bin,i3,kitty,nvim,personal,picom,polybar,rofi,tmux,zsh`)
- `./macos` — macOS install (default stow: `bin,skhd,yabai,kitty,nvim,personal,tmux,zsh`)
- `./clean-env` — Unstows all folders (removes all symlinks)

To stow a single package manually:
```sh
cd ~/.dotfiles
stow <package-name>          # stow
stow -D <package-name>       # unstow
stow -R <package-name>       # restow (unstow + stow)
```

## Architecture

### Directory Structure
Each top-level directory is a Stow package that mirrors `$HOME`:
```
<package>/
  .config/<app>/    → ~/.config/<app>/
  .local/bin/       → ~/.local/bin/
```

### Neovim
Config lives in `nvim/.config/nvim/` as a **git submodule** pointing to `git@github.com:swkoyo/nvim-config.git`. Update with:
```sh
git submodule update --remote nvim/.config/nvim
```

**LSP setup:**
- Uses **mason.nvim**, **mason-lspconfig.nvim** (v2), and **nvim-lspconfig**
- Mason-lspconfig v2 uses `vim.lsp.config()` + `automatic_enable = true` (the old `handlers` API was removed in v2)
- LSP keymaps (`gd`, `gr`, etc.) use built-in `vim.lsp.buf` functions (not Telescope, to avoid Neovim 0.11 deprecation warnings)
- Diagnostic signs use `vim.diagnostic.config()` with `signs.text` table (not the deprecated `sign_define()`)
- Python: **basedpyright** (type checking) + **ruff** (linting/formatting)
- Config file: `nvim/.config/nvim/lua/plugins/lsp/lspconfig.lua`

**Important:** When updating Neovim plugins, watch for breaking API changes in mason-lspconfig and Neovim's built-in LSP APIs. Neovim 0.11 deprecated many `vim.lsp.util` functions.

### Personal Settings
Shared shell settings live in `personal/.config/personal/`:
- `env` — environment variables and utility functions
- `alias` — shell aliases (uses `lsd`, `bat`, `lazygit`)
- `path` — PATH additions for Homebrew, pyenv, bun, etc.

Zsh sources these via `zsh/.zshrc`.

### Shell (Zsh)
- Framework: Oh My Zsh
- Prompt: Starship
- Plugins: git, zsh-autosuggestions, zsh-syntax-highlighting
- Navigation: Zoxide

### Tmux
- Prefix: `Ctrl+A`
- Plugin manager: TPM (`~/.tmux/plugins/tpm`)
- Theme: Tokyo Night
- `<prefix>f` launches `tmux-sessionizer` (fzf-based session manager in `bin/.local/scripts/`)

### Platform Split
| Tool | Linux | macOS |
|------|-------|-------|
| WM | Hyprland (Wayland) / i3 (X11) | AeroSpace / Yabai |
| Bar | Waybar / Polybar | Sketchybar |
| Hotkeys | Hyprland binds | skhd |
| Notifications | Swaync / Dunst | — |

### Theme
Tokyo Night is used consistently across Tmux, Rofi, and terminal configs.

## Project-Local Neovim Config
`.nvim.lua` at the repo root sets Telescope keybindings for navigating this repo within Neovim.
