local config = require("config.llm").get_config()
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  opts = {
    provider = config.provider,
    hints = { enabled = false },
    vendors = {
      ---@type AvanteProvider
      groq = {
        __inherited_from = "openai",
        endpoint = "https://api.groq.com/openai/v1/chat/completions",
        model = config.model,
        api_key_name = "GROQ_API_KEY",
      },
      ---@type AvanteProvider
      deepinfra = {
        __inherited_from = "openai",
        endpoint = "https://api.deepinfra.com/v1/openai",
        model = config.model,
        api_key_name = "DEEPINFRA_API_KEY",
      },
      ---@type AvanteProvider
      litellm = {
        __inherited_from = "openai",
        endpoint = "https://litellm.vpn.r00t.ca",
        model = config.model,
        api_key_name = "LITELLM_API_KEY",
      },
      ---@type AvanteProvider
      ollama = {
        __inherited_from = "openai",
        api_key_name = "",
        endpoint = "127.0.0.1:11434/v1",
        model = config.model,
      },
    }
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      },
    },
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
