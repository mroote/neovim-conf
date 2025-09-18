return {
  "ravitemer/mcphub.nvim",
  event = 'VeryLazy',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  version = false, -- Never set this value to "*"! Never!
  build = "yarn global add mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
  config = function()
    require("mcphub").setup()
  end
}
