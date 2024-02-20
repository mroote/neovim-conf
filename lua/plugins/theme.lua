return {
  vim.g.colorscheme.url,
  priority = 1000,
  lazy = false,
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    require(vim.g.colorscheme.name).load()
  end
}
