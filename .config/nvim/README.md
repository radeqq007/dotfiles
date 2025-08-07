# My nvim config

A simple Neovim configuration with LSP support, autompletion, and bunch of useful plugins.

## Instalation

1. Clone this repository to your Neovim config directory:

```bash
git clone https://github.com/radeqq007/nvim-config ~/.config/nvim
```

2. Clone the [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) repository into your packages directory:
```bash
git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
```

2. Start Neovim

## Key Mappings

- `<Space>` - Leader key
- `<leader>pv` - Open file explorer
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help tags

## Plugin List

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configuration [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [copilot.vim](https://github.com/github/copilot.vim) - GitHub Copilot
- [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) - Color scheme
- [vim-wakatime](https://github.com/wakatime/vim-wakatime) - Wakatime tracking
- [autopairs](https://github.com/windwp/nvim-autopairs) - Auto Closing Pairs
