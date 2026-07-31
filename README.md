# Cachy OS + Hyprland config

My hyprland configuration with noctalia.


## Installation

Clone the repo:

```sh
git clone https://github.com/radeqq007/dotfiles.git
```

Or with the submodules if you want the Neovim config included:

```sh
git clone --recurse-submodules https://github.com/radeqq007/dotfiles.git
```

Then cd into the directory and apply the dotfiles using [stow](https://github.com/aspiers/stow):

```sh
cd dotfiles
stow .
```

``

## Config includes

### Hyprland

Main config is located in `.config/hypr/hyprland.lua` which imports the respective files:

- `.config/hypr/modules/autostart.lua` - contains applications that start on startup (waybar, hyprpaper, poweralertd etc.)
- `.config/hypr/modules/appearance.lua` - contains animations, appearance and visual settings
- `.config/hypr/modules/input.lua` - contains the keyboard layout and touchpad scroll behavior / gestures config
- `.config/hypr/modules/keybinds.lua` - contains the keybindings listed below
  - `SUPER` as the main mod key
  - `mainMod + L` - hyprlock
  - `mainMod + Q` - terminal (ghostty)
  - `mainMod + B` - browser (Zen)
  - `mainMod + F` - file manager (thunar)
  - `mainMod + Space` - noctalia launcher
  - `mainMod + V` - toggle windows floating
  - `mainMod + M` - stop the current uwsm session
  - `mainMod + .` - noctalia emoji selector
  - `mainMod + P` - enable pseudotiling
  - `mainMod + /` - toggle split
  - `mainMod + left / h` - move focus to left
  - `mainMod + right / l` - move focus to right
  - `mainMod + up / k` - move focus up
  - `mainMod + down / j` - move focus down
  - `mainMod + <1-10>` - switch workspaces
  - `mainMod + <numpad keys respective to the numbers>` - switch workspaces
- `.config/hypr/modules/monitors.lua` - monitors config
- `.config/hypr/modules/windows.lua` - windows behavior

### fish

- zoxide

### Fastfetch

![fastfetch screenshot](./screenshots/fastfetch.png)

### Neovim

Linked as a submodule. The full NeoVim config and its details are located in [this repo](https://github.com/radeqq007/nvim-config).

