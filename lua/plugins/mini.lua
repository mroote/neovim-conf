return {
  -- Add mini nvim 
  'echasnovski/mini.nvim',
  version = '*',
  config = function ()
    require("mini.surround").setup {}
    require("mini.starter").setup {
      header = os.date(),
    }
  end
}
