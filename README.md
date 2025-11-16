# Neovim Configuration

A clean, modular Neovim configuration based on Kickstart.nvim.

## Structure

```
~/.config/nvim/
├── init.lua                  # Main entry point (52 lines, was 1489!)
├── init.lua.backup          # Your original config (backup)
├── lua/
│   ├── core/                # Core Neovim settings
│   │   ├── options.lua      # Vim options and settings
│   │   ├── keymaps.lua      # Global key mappings
│   │   ├── autocmds.lua     # Autocommands
│   │   └── lazy.lua         # Plugin manager bootstrap
│   └── plugins/             # Plugin configurations (auto-loaded)
│       ├── colorscheme.lua  # Kanagawa theme
│       ├── ui.lua           # UI plugins (alpha, mini, which-key, bufferline, etc.)
│       ├── telescope.lua    # Fuzzy finder
│       ├── lsp.lua          # LSP configuration
│       ├── completion.lua   # nvim-cmp and Copilot
│       ├── treesitter.lua   # Syntax highlighting
│       ├── formatting.lua   # Code formatting (conform.nvim)
│       ├── linting.lua      # Linting (nvim-lint)
│       ├── testing.lua      # Testing (neotest)
│       ├── git.lua          # Git plugins (gitsigns, diffview, lazygit)
│       └── editor.lua       # Editor plugins (autopairs, neo-tree, toggleterm, spectre)
```

## Benefits

### Before (Single init.lua)
- 1489 lines in one file
- Hard to navigate and maintain
- Difficult to find specific configurations
- Overwhelming for newcomers

### After (Modular Structure)
- **init.lua**: 52 lines (97% reduction!)
- **Organized by category**: Easy to find what you need
- **Easy to extend**: Just add a new file in lua/plugins/
- **Better performance**: Lazy-loading organized by plugin
- **Maintainable**: Each file has a single responsibility

## How to Use

### Viewing Configuration
- **Options**: ~/.config/nvim/lua/core/options.lua
- **Keymaps**: ~/.config/nvim/lua/core/keymaps.lua
- **Autocommands**: ~/.config/nvim/lua/core/autocmds.lua
- **Plugins**: ~/.config/nvim/lua/plugins/[category].lua

### Customizing Bufferline
Edit lua/plugins/ui.lua and find the bufferline setup.

## Backup

Your original config is saved at: ~/.config/nvim/init.lua.backup
