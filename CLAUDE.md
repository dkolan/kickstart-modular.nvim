# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modular Neovim configuration based on kickstart.nvim. It's a personal configuration fork that uses lazy.nvim for plugin management and is organized into separate modules rather than a single init.lua file.

## Architecture

### Entry Point and Loading Order
The configuration loads in this specific order (defined in init.lua):
1. Leader key setup (`vim.g.mapleader = ' '`)
2. `lua/options.lua` - Editor settings
3. `lua/keymaps.lua` - Basic keybindings
4. `lua/lazy-bootstrap.lua` - Lazy.nvim plugin manager installation
5. `lua/lazy-plugins.lua` - Plugin loading configuration

### Plugin Organization
Plugins are organized into two main categories:

**Kickstart plugins** (`lua/kickstart/plugins/*.lua`):
- Core, well-tested plugins from the kickstart.nvim project
- Each plugin is in its own file and returns a lazy.nvim plugin spec
- Files use dot syntax for module paths (e.g., `require 'kickstart.plugins.lspconfig'`)
- Major plugins include: lspconfig, telescope, conform, blink-cmp, treesitter, which-key, gitsigns

**Custom plugins** (`lua/custom/plugins/*.lua`):
- User-added plugins that are imported via `{ import = 'custom.plugins' }` in lazy-plugins.lua
- This directory is explicitly preserved across upstream merges
- The init.lua in this directory serves as a placeholder

### LSP Configuration
LSP setup is centralized in `lua/kickstart/plugins/lspconfig.lua`:
- Uses Mason for automatic LSP server installation
- Custom clangd configuration pointing to Homebrew installation at `/opt/homebrew/opt/llvm/bin/clangd`
- LSP keymaps are defined in an `LspAttach` autocommand (grn, gra, grr, gri, grd, etc.)
- Custom diagnostic configuration with severity sorting and rounded borders
- Capabilities are extended by blink.cmp for enhanced completion

### Formatting
Conform.nvim handles code formatting (`lua/kickstart/plugins/conform.lua`):
- Format on save is **enabled** for C and C++ files
- Manual formatting available via `<leader>f`
- Configured formatters: stylua (Lua), clang-format (C/C++)

### Debugging
nvim-dap is configured for C++ debugging (`lua/kickstart/plugins/debug.lua` + `lua/custom/plugins/cpp-debug.lua`):
- Uses CodeLLDB debug adapter (installed via Mason)
- Debug UI (dap-ui) opens automatically when debugging starts
- C++ configurations support both launching executables and attaching to processes
- The program path is prompted when starting a debug session (or can be configured per-project)

## Common Commands

### Plugin Management
```vim
:Lazy                " View plugin status
:Lazy update         " Update all plugins
:Lazy sync           " Install missing, clean unused plugins
```

### LSP and Tools
```vim
:Mason               " Open Mason installer (for LSP servers, formatters, linters)
:LspInfo             " Show LSP server status for current buffer
:ConformInfo         " Show conform formatter info
:checkhealth         " Run Neovim health checks
```

### Debugging
- `F5` - Start/Continue debugging
- `F1` - Step into
- `F2` - Step over
- `F3` - Step out
- `F7` - Toggle debug UI
- `<leader>b` - Toggle breakpoint
- `<leader>B` - Set conditional breakpoint

### Formatting
- `<leader>f` - Manually format current buffer (in normal or visual mode)
- Format on save is automatic for all configured languages including C/C++

### Key Keymaps
- `<leader>` is Space
- `<leader>sh` - Search help docs
- `<leader>sf` - Find files
- `<leader>sg` - Live grep
- `<leader>sn` - Search Neovim config files
- LSP: `grn` (rename), `grd` (go to definition), `grr` (references), `gra` (code action)

## Development Guidelines

### Adding New Plugins
Place new plugins in `lua/custom/plugins/` directory:
- Create a new `.lua` file that returns a lazy.nvim plugin spec table
- The file will be automatically loaded via the `{ import = 'custom.plugins' }` in lazy-plugins.lua
- Follow the same pattern as kickstart plugins (return a table/array of plugin specs)

### Modifying Configuration
- **Options**: Edit `lua/options.lua`
- **Keymaps**: Edit `lua/keymaps.lua` for global keymaps
- **LSP settings**: Edit `lua/kickstart/plugins/lspconfig.lua`
- **Formatters**: Edit `lua/kickstart/plugins/conform.lua`

### Module Path Syntax
This configuration uses dot notation for requires:
- `require 'module.submodule'` instead of `require('module.submodule')`
- This is a stylistic choice for cleaner code

### Maintaining Upstream Compatibility
This is a fork of dam9000/kickstart-modular.nvim. The `lua/custom/` directory is the safe zone for personal modifications that won't conflict with upstream updates.

## C++ Development Workflow

### First-time Setup
After restarting Neovim, Mason will automatically install:
- `clangd` (LSP server)
- `clang-format` (formatter)
- `codelldb` (debugger)

### Debugging C++ Code
1. Compile your program with debug symbols (`-g` flag)
2. Open a C++ file in the project
3. Set breakpoints with `<leader>b`
4. Press `F5` to start debugging
5. You'll be prompted for the executable path (e.g., `./build/my_program`)
6. Use F1/F2/F3 to step through code
7. The debug UI shows variables, call stack, and breakpoints

### Per-Project Debug Configuration
For projects where you want to skip the executable prompt, edit `lua/custom/plugins/cpp-debug.lua` and modify the `program` field to point directly to your binary or a project-specific function.

## Important Notes

- Nerd Font support: Currently `vim.g.have_nerd_font = false` in init.lua - set to true if a Nerd Font is installed
- Default indentation: 4 spaces (tabstop=4, shiftwidth=4)
- Clipboard: Syncs with system clipboard (`clipboard = 'unnamedplus'`)
- Relative line numbers are enabled
- C/C++ format on save is enabled - disable specific filetypes in conform configuration if needed
