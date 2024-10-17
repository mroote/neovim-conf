return {
  vim.g.theme.url,
  priority = 1000,
  lazy = false,
  dependencies = { 'rktjmp/lush.nvim' },
  init = function()
    vim.cmd.colorscheme(vim.g.theme.name)
  end,
}
