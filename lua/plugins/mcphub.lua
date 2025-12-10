return {
  "ravitemer/mcphub.nvim",
  event = 'VeryLazy',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "yarn global add mcp-hub",  -- Installs `mcp-hub` node binary globally
  opts = {},
}
