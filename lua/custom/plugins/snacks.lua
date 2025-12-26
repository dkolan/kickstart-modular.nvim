-- Snacks.nvim - Collection of useful utilities
-- https://github.com/folke/snacks.nvim

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true }, -- Handle large files efficiently
    dashboard = { enabled = false }, -- Start screen (disabled for now)
    explorer = { enabled = true }, -- File browser
    indent = { enabled = true }, -- Visual indent guides
    input = { enabled = true }, -- Better input dialogs
    notifier = { enabled = true }, -- Notification system
    picker = { enabled = true }, -- Smart file/buffer picker
    quickfile = { enabled = true }, -- Quick file operations
    scope = { enabled = true }, -- Scope highlighting
    scroll = { enabled = true }, -- Smooth scrolling
    statuscolumn = { enabled = true }, -- Status column enhancements
    words = { enabled = true }, -- Word highlighting
    termina = { enabled = true }, -- Termianl floating
  },
  keys = {
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'Toggle File [E]xplorer',
    },
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = '[,] Buffers',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = '[/] Grep',
    },
    {
      '<leader>t',
      function()
        Snacks.terminal()
      end,
      desc = '[T]erminal',
    },
  },
  config = function(_, opts)
    local snacks = require 'snacks'
    snacks.setup(opts)

    -- Set up debugging utilities
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd
      end,
    })
  end,
}
