local config = require("config.llm").get_config()

return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- The following are optional:
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  },
  config = true,
  opts = {
    display = {
      chat = {
        render_headers = false,
      }
    },
    adapters = {
      opts = {
        show_defaults = false,
      },
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = os.getenv("ANTHROPIC_API_KEY")
          },
        })
      end,
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = config.model,
            }
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = config.provider,
      },
      inline = {
        adapter = config.provider,
      },
    },
  }
}
