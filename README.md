<!-- panvimdoc-ignore-start -->

[End4HyprdotsNvimInAction.webm](https://github.com/user-attachments/assets/f443e131-eff8-4586-b41a-56ad54851414)


# end-4-hyprdots Neovim theme

This theme is forked from [catppuccin/nvim](https://github.com/catppuccin/nvim) with two flavours (light/dark)
whose palettes are updated when switching your background (assuming you use
[end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)) on Hyprland.

You can refer to the documentation of catppuccin to configure this theme.

# Features

* Generates and loads a neovim theme depending on your choice of wallpaper and illogical-impulse scheme. Colors are based on end-4's terminal theme engine.
* Hot-reload for dark/light transition only (I could not find a way to do the others in Neovim).

# Prerequisites

* [Neovim](https://neovim.io/) (tested on version 0.11.2)
* [Hyprland](https://wiki.hypr.land/Getting-Started/Master-Tutorial/) (tested on version 0.50.0)
* [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland) (tested on the version of the 13th of May 2025)

# Installation (with lazy.nvim) and usage

Install the plugin:

```lua
return {
    "Silzinc/end-4-hyprdots.nvim",
    opts = {} -- Put your catppuccin-like options here
}
```

Load the theme:
```lua
-- Automatic dark/light detection
vim.cmd.colorscheme("end-4-hyprdots")
-- Or, to force a specific one
vim.cmd.colorscheme("end-4-hyprdots-light")
vim.cmd.colorscheme("end-4-hyprdots-dark")
