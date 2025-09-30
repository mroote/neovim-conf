return {
  "ravitemer/mcphub.nvim",
  event = 'VeryLazy',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  version = false, -- Never set this value to "*"! Never!
  build = "yarn global add mcp-hub@4.2.1",  -- Installs `mcp-hub` node binary globally
  opts = {},
}
