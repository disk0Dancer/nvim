# Neovim Config

My daily Neovim setup based on [LazyVim](https://github.com/LazyVim/LazyVim).

## Quick Install (macOS)

Prerequisites:
- Neovim >= 0.10
- Git
- `ripgrep` (`brew install ripgrep`)
- `fd` (`brew install fd`)
- Nerd Font in terminal

Install:

```bash
# backup old config (optional)
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim ~/.cache/nvim.bak 2>/dev/null

# clone config
git clone git@github.com:disk0Dancer/nvim.git ~/.config/nvim

# first start
nvim
```

Inside Neovim:
- run `:Lazy sync`
- run `:checkhealth`

## Included UX choices

- Theme: `tokyonight`
- File explorer: `oil.nvim` (`<leader>e` and `-`)
- Buffer tabs: `bufferline.nvim`
- Clipboard: system clipboard enabled (`unnamedplus`)
