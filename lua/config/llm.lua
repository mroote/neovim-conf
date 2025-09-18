local M = {}

M.configs = {
  work = {
    provider = "copilot",
    model = "claude-sonnet-4"
  },
  personal = {
    provider = "litellm",
    model = "qwen3-coder",
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
  require("codecompanion.adapters").set_model(model)
  M.set_avante_model(model)
end

-- Switch between configurations
function M.switch_config(config_name)
  if not M.configs[config_name] then
    vim.notify("Configuration '" .. config_name .. "' not found", vim.log.levels.ERROR)
  end
  M.active_config = config_name
  M.set_avante_provider(M.configs[config_name].provider)
  M.set_config_model(M.configs[config_name].model)
  vim.notify("Switched to configuration: " .. config_name, vim.log.levels.INFO)
end

-- List available configurations
function M.list_configs()
  local configs = {}
  for name, _ in pairs(M.configs) do
    table.insert(configs, name)
  end
  return configs
end

function M.set_avante_provider(provider_name)
  require("avante.api").switch_provider(provider_name)

end

function M.set_avante_model(model_name)
  local Config = require("avante.config")
  local Providers = require("avante.providers")
  local provider = M.configs[M.active_config].provider

  Config.override({
    providers = {
      [provider] = vim.tbl_deep_extend(
        "force",
        Config.get_provider_config(provider),
        { model = model_name }
      ),
    },
  })
  local provider_cfg = Providers[provider]
  if provider_cfg then provider_cfg.model = model_name end
end

function M.print_current_config()
  local config = M.get_config()
  vim.notify("Current config: " .. M.active_config .. "\n(Provider: " ..
    config.provider .. ", Model: " .. config.model .. ")", vim.log.levels.INFO)
end

-- Create a custom Neovim command to set the model
vim.api.nvim_create_user_command("SetLLMModel", function(args)
  M.set_config_model(args.args)
  vim.notify("Model set to: " .. args.args)
end, {
  nargs = 1,  -- Require one argument (the model name)
  desc = "Set the LLM model"
})

-- Command to show current configuration
vim.api.nvim_create_user_command("ShowLLMConfig", function()
  M.print_current_config()
end, {
  desc = "Show current LLM configuration"
})

-- Command to switch configurations
vim.api.nvim_create_user_command("SwitchLLMConfig", function(args)
  M.switch_config(args.args)
end, {
  nargs = 1,
  desc = "Switch LLM configuration",
  complete = function()
    M.print_current_config()
  end
})

return M
