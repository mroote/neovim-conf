local themes = {
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    lazy = true,
    config = function() vim.print("setup gruvbox-material") end,
  },
  {
    "sainnhe/sonokai",
    name = "sonokai",
    lazy = true,
    config = function()
      vim.print("setup sonokai")
      vim.g.sonokai_style = 'atlantis'
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = true,
    config = function() vim.print("setup kanagawa") end,
  },
}

vim.keymap.set("n", "<leader>uu", function()
  for _, color in ipairs(themes) do
    vim.cmd("Lazy load " .. color.name)
  end

  vim.schedule(function() --> Needs to be scheduled:
    local completion = vim.fn.getcompletion
    vim.cmd("FzfLua colorschemes")
    vim.fn.getcompletion = completion
  end)
end, { desc = "Colorscheme colors", silent = true })

if vim.g.theme and vim.g.theme ~= '' then
  for _, theme in ipairs(themes) do
    if theme.name == vim.g.theme then
      theme.lazy = false
      theme.priority = 1000
      theme.config = function()
        vim.cmd.colorscheme(vim.g.theme)
      end
    end
  end
end

return themes
