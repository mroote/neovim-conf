local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      theme = vim.g.theme.name,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        'packer',
        'neo-tree',
        'toggleterm',
        'winbar'
      },
    },
    sections = {
      lualine_b = {
        { 'branch' },
        { "diff", source = diff_source },
      },
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}
