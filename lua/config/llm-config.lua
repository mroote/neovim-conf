local M = {}

-- Define different configurations
M.configs = {
  work = {
    provider = "copilot",
    copilot = {
      model = "claude-3.5-sonnet"
    },
  },
  personal = {
    provider = "ollama",
  }
}

-- You can set this in your init.lua or other configuration
M.active_config = os.getenv("LLM_ENV") or "personal"

-- Helper function to get current config
function M.get_config()
  return M.configs[M.active_config]
end

return M
