return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  version = false, -- Never set this value to "*"! Never!
  build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
  config = function()
    require("mcphub").setup()
  end
}
