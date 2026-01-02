-- nvim-surround: Add/change/delete surrounding delimiter pairs with ease
-- Examples:
--   In visual mode: Select text, press 'S' then the character (like '(' or '"')
--   Normal mode: ys + motion + char (e.g., ysiw) to surround word with )
--   Change: cs + old + new (e.g., cs"' changes "hello" to 'hello')
--   Delete: ds + char (e.g., ds" removes quotes)

return {
  'kylechui/nvim-surround',
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {
      -- Configuration here, or leave empty to use defaults
      keymaps = {
        insert = '<C-g>s',
        insert_line = '<C-g>S',
        normal = 'ys',
        normal_cur = 'yss',
        normal_line = 'yS',
        normal_cur_line = 'ySS',
        visual = 'S',
        visual_line = 'gS',
        delete = 'ds',
        change = 'cs',
        change_line = 'cS',
      },
    }
  end,
}
