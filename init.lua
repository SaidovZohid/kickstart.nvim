--[[
=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

=====================================================================
=====================================================================

This is a modular Neovim configuration based on Kickstart.nvim

Structure:
  ├── init.lua              (This file - loads everything)
  ├── lua/
  │   ├── core/             (Core Neovim settings)
  │   │   ├── options.lua   (Vim options)
  │   │   ├── keymaps.lua   (Key mappings)
  │   │   ├── autocmds.lua  (Autocommands)
  │   │   └── lazy.lua      (Plugin manager setup)
  │   └── plugins/          (Plugin configurations)
  │       ├── colorscheme.lua
  │       ├── ui.lua
  │       ├── telescope.lua
  │       ├── lsp.lua
  │       ├── completion.lua
  │       ├── treesitter.lua
  │       ├── formatting.lua
  │       ├── linting.lua
  │       ├── testing.lua
  │       ├── git.lua
  │       └── editor.lua

To customize:
  - Edit files in lua/core/ for Neovim settings
  - Edit files in lua/plugins/ for plugin configurations
  - Add new plugin files in lua/plugins/ (they'll auto-load)

--]]

-- Load core configuration
require 'core.options'
require 'core.keymaps'
require 'core.autocmds'

-- Bootstrap and load plugins
require 'core.lazy'
