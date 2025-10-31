return {
  "ravitemer/mcphub.nvim",
  event = 'VeryLazy',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "yarn global add mcp-hub@4.2.1",  -- Installs `mcp-hub` node binary globally
  opts = {},
}
