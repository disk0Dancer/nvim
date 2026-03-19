# disk0Dancer nvim

Personal Neovim setup based on [LazyVim](https://github.com/LazyVim/LazyVim).

## Install In One Command (macOS)

The command below:
- installs Homebrew if missing
- installs all required tools via `brew` (including `lazygit` and `lazydocker`)
- backs up old `~/.config/nvim`
- clones this config

```bash
/bin/bash -c 'set -euo pipefail
if ! command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
brew update
brew install neovim git ripgrep fd fzf lazygit lazydocker tmux uv go node python@3.12
mkdir -p ~/.config
if [ -d ~/.config/nvim ]; then
  mv ~/.config/nvim ~/.config/nvim.bak.$(date +%Y%m%d-%H%M%S)
fi
git clone https://github.com/disk0Dancer/nvim.git ~/.config/nvim
echo "Done. Start Neovim with: nvim"
'
```

## First Start

After install:
- open `nvim`
- run `:Lazy sync`
- run `:checkhealth`

## tmux Colors and Clipboard

If you use tmux, add this to `~/.tmux.conf`:

```tmux
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",xterm-256color:Tc"
set -g set-clipboard on
```

Reload tmux config:

```bash
tmux source-file ~/.tmux.conf
```

## UX Defaults In This Config

- Theme: `tokyonight`
- File explorer: `oil.nvim` (`<leader>e` and `-`)
- Buffer tabs: `bufferline.nvim`
- Statusline: `lualine.nvim`
- Clipboard: `unnamedplus`

## Plugins In Use

From current `lazy-lock.json`:

- `LazyVim`
- `LuaSnip`
- `SchemaStore.nvim`
- `blink-copilot`
- `blink.cmp`
- `bufferline.nvim`
- `catppuccin`
- `conform.nvim`
- `copilot.lua`
- `flash.nvim`
- `friendly-snippets`
- `gitsigns.nvim`
- `grug-far.nvim`
- `haskell-snippets.nvim`
- `haskell-tools.nvim`
- `inc-rename.nvim`
- `lazy.nvim`
- `lazydev.nvim`
- `lualine.nvim`
- `mason-lspconfig.nvim`
- `mason.nvim`
- `mini.ai`
- `mini.icons`
- `mini.pairs`
- `noice.nvim`
- `nui.nvim`
- `nvim-lint`
- `nvim-lspconfig`
- `nvim-treesitter`
- `nvim-treesitter-textobjects`
- `nvim-ts-autotag`
- `nvim-web-devicons`
- `oil.nvim`
- `persistence.nvim`
- `plenary.nvim`
- `snacks.nvim`
- `todo-comments.nvim`
- `tokyonight.nvim`
- `trouble.nvim`
- `ts-comments.nvim`
- `which-key.nvim`
