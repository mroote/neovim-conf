local M = {}

M.configs = {
  work = {
    provider = "copilot",
    copilot = {
      model = "claude-3.5-sonnet"
    },
  },
  personal = {
    provider = "litellm",
    model = "DeepSeek-V3",
  }
}

M.active_config = os.getenv("LLM_ENV") or "personal"

-- Helper function to get current config
function M.get_config()
  return M.configs[M.active_config]
end

function M.set_config_model(model)
  M.configs[M.active_config].model = model
end

-- Create a custom Neovim command to set the model
vim.api.nvim_create_user_command("SetLLMModel", function(args)
  M.set_config_model(args.args)
  print("Model set to: " .. args.args)
end, {
  nargs = 1,  -- Require one argument (the model name)
  desc = "Set the LLM model"
})



return M
