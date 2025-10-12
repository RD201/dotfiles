## Summary

- Font: `FiraCode`
- Icons: `Gruvbox Plus`
- Composer: `picom`:
- Tiling window manager: `i3wm`:
- D-menu: `rofi`
- Terminal: `kitty`
- Multiplexer: `tmux`
- Editor: `nvim`

### Installation

Use [chezmoi](https://www.chezmoi.io/) to manage this repository dotfiles.

### FiraCode

- Download [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) & `unzip` it into `~/.local/share/fonts/`
- Then apply it with `gnome-tweaks`

### Icons

See [Gruvbox Plus docs](https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases)

### Rofi

Used for dmenu & powermenu.

- `sudo apt install rofi`
- config at `.config/rofi`

### Picom

Using picom as compositor (previously compton, though it's still required a dependency I think).

`sudo apt install picom` & `sudo apt compton`

### i3wm

#### Binds

- Screen lightning management uses `xbacklight` & keyboard
  - I encountered an issue setting it up & followed this [solution](https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder)

#### Scripts

Don't forget to make them executable (`chmod +x`)

- `lock` with blur requires `scrot` & `imagemagick`

#### Wallpaper

Wallpaper is loaded at startup using `feh`

### Kitty Terminal

See [the website !](https://sw.kovidgoyal.net/kitty/)

### Zsh

Install zsh & use the `.zshrc`

__Note__: This repository stores a `.zshrc.bak` to avoid committing current `.zshrc` which may contain secrets, credentials or work/personal-related informations.

#### Oh My ZSH

Plugin & theme manager for zsh.

- Install the plugins found in the `.zshrc`
- Use zsh theme in repo (move it at `.oh-my-zsh/theme`)

### Tmux

Config at `~/.tmux.conf`

#### Tmux Plugin Manager

https://github.com/tmux-plugins/tpm

### Nvim

Config at `.config/nvim`
