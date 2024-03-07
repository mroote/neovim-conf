return {
  'RaafatTurki/corn.nvim',
  event = 'LspAttach',
  opts = {},
  config = function()
    -- Show error diagnostics
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
  end
}
