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
        window = {
          position = "right"
        },
      }
    },
    adapters = {
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = "CC_OAUTH_TOKEN",
            },
          })
        end,
      },
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
        tools = {
          opts = {
            auto_submit_errors = true, -- Send any errors to the LLM automatically?
            auto_submit_success = true, -- Send any successful output to the LLM automatically?
          },
        },
        keymaps = {
          close = {
            modes = {
              n = "<C-c>",
              i = "<C-c>",
            },
            index = 3,
            callback = function()
              require("codecompanion").toggle()
            end,
            description = "Toggle Chat",
          },
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
