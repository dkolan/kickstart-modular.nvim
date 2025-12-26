-- C++ debugging configuration for nvim-dap
-- This extends the base debug.lua configuration with C++ specific adapters

return {
  'mfussenegger/nvim-dap',
  optional = true, -- Only loads if debug.lua is enabled
  config = function()
    local dap = require 'dap'

    -- Configure C++ debugging with CodeLLDB (recommended for C++ on macOS)
    -- Falls back to lldb if codelldb isn't available
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        -- Mason will install codelldb, or you can use system lldb
        command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
      },
    }

    -- C++ debug configurations
    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        -- TODO(human): Set the program path for your project
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
      {
        name = 'Attach to process',
        type = 'codelldb',
        request = 'attach',
        pid = require('dap.utils').pick_process,
        args = {},
      },
    }

    -- Use the same configuration for C
    dap.configurations.c = dap.configurations.cpp

    -- Alternative: Configure with lldb-vscode/lldb-dap (built into LLVM)
    -- Uncomment this if you prefer to use the lldb that comes with your Homebrew LLVM
    --
    -- dap.adapters.lldb = {
    --   type = 'executable',
    --   command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
    --   name = 'lldb',
    -- }
    --
    -- dap.configurations.cpp = {
    --   {
    --     name = 'Launch',
    --     type = 'lldb',
    --     request = 'launch',
    --     program = function()
    --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --     },
    --     cwd = '${workspaceFolder}',
    --     stopOnEntry = false,
    --     args = {},
    --   },
    -- }
  end,
}
