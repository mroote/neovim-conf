return {
  vim.g.theme.url,
  priority = 1000,
  lazy = false,
  dependencies = { 'rktjmp/lush.nvim' },
  init = function()
    if vim.g.theme.config then
      for k, v in pairs(vim.g.theme.config) do
        vim.g[k] = v
      end
    end

    vim.cmd.colorscheme(vim.g.theme.name)
  end
}
