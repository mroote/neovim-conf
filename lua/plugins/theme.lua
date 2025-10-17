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
    "Shatur/neovim-ayu",
    name = "ayu-dark",
    lazy = true,
    config = function() vim.print("setup ayu-dark") end,
  },
  {
    "NTBBloodbath/doom-one.nvim",
    name = "doom-one",
    lazy = true,
    config = function() vim.print("setup doom-one") end,
  },
  {
    "AlessandroYorba/Despacio",
    name = "despacio",
    lazy = true,
    config = function()
      vim.print("setup despacio")
      vim.g.espacio_Midnight = 1
    end,
  },
  {
    "fenetikm/falcon",
    name = "falcon",
    lazy = true,
    config = function()
      vim.print("setup falcon")
      vim.g.falcon_background = 1
      vim.g.falcon_inactive = 1
    end,
  },
  {
    "sainnhe/edge",
    name = "edge",
    lazy = true,
    config = function()
      vim.print("setup edge")
      vim.g.edge_enable_italic = true
      vim.g.edge_style = 'neon'
      vim.g.edge_better_performance = 1
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function() vim.print("setup catppuccin") end,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = true,
    config = function() vim.print("setup kanagawa") end,
  },
  {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = true,
    config = function() vim.print("setup nord") end,
  },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    name = "no-clown-fiesta",
    lazy = true,
    config = function() vim.print("setup no-clown-fiesta") end,
  },
  {
    "datsfilipe/vesper.nvim",
    name = "vesper",
    lazy = true,
    config = function() vim.print("setup vesper") end,
  },
  {
    "yorumicolors/yorumi.nvim",
    name = "yorumi",
    lazy = true,
    config = function() vim.print("setup yorumi") end,
  },
  {
    "neanias/everforest-nvim",
    name = "everforest",
    lazy = true,
    config = function() vim.print("setup everforest") end,
  },
}

vim.keymap.set("n", "<leader>uu", function()
  for _, color in ipairs(themes) do
    vim.cmd("Lazy load " .. color.name) --> vim colorschemes cannot be required...
  end

  vim.schedule(function() --> Needs to be scheduled:
    local completion = vim.fn.getcompletion
    vim.cmd("FzfLua colorschemes")
    vim.fn.getcompletion = completion
  end)
end, { desc = "Telescope custom colors", silent = true })

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
