return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = 'gruvbox',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
    },
    sections = {
      lualine_b = {
        { 'branch' },
        { "diff", source = diff_source },
      },
      lualine_z = {
        {
          'datetime',
          style = "%H:%M"
        },
      }
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}
