return {
  -- Add mini nvim
  'echasnovski/mini.nvim',
  version = '*',
  event = "VeryLazy",
  config = function ()
    require("mini.surround").setup {}
    require("mini.starter").setup {
      header = os.date(),
    }
    require('mini.trailspace').setup({})
    require('mini.cursorword').setup({})
    require('mini.bufremove').setup({})
    require('mini.comment').setup({})
  end
}
