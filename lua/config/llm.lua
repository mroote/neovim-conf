local M = {}

M.configs = {
  work = {
    provider = "copilot",
    model = "claude-3.7-sonnet"
  },
  personal = {
    provider = "litellm",
    model = "deepinfra/Qwen/Qwen3-235B-A22B",
  }
}

M.active_config = os.getenv("LLM_ENV") or "personal"

-- Helper function to get current config
function M.get_config()
  return M.configs[M.active_config]
end

function M.set_config_provider(provider)
  M.configs[M.active_config].provider = provider
end

function M.set_config_model(model)
  M.configs[M.active_config].model = model
end

-- Create a custom Neovim command to set the model
vim.api.nvim_create_user_command("SetLLMModel", function(args)
  local Config = require("avante.config")
  local Providers = require("avante.providers")
  local provider = M.configs[M.active_config].provider

  M.set_config_model(args.args)
  Config.override({
    providers = {
      [provider] = vim.tbl_deep_extend(
        "force",
        Config.get_provider_config(provider),
        { model = args.args }
      ),
    },
  })
  local provider_cfg = Providers[provider]
  if provider_cfg then provider_cfg.model = args.args end

  print("Model set to: " .. args.args)
end, {
  nargs = 1,  -- Require one argument (the model name)
  desc = "Set the LLM model"
})

return M
