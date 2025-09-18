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
  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()
  end,
  opts = {
    display = {
      chat = {
        render_headers = true,
        show_settings = true,
      }
    },
    adapters = {
      http = {
        litellm = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://litellm.vpn.r00t.ca",
              api_key = "LITELLM_API_KEY",
              chat_url = "/v1/chat/completions",
              models_endpoint = "/v1/models",
            },
            schema = {
              model = {
                default = config.model,
              },
            }
          })
        end,
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
        opts = {
          show_defaults = false,
        },
      },
    },
    strategies = {
      chat = {
        adapter = {
          name = config.provider,
          model = config.model,
        },
      },
      inline = {
        adapter = {
          name = config.provider,
          model = config.model,
        },
      },
      cmd = {
        adapter = {
          name = config.provider,
          model = config.model,
        },
      },
    },
  }
}
