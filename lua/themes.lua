local M = {}

M.themes = {
  gruvbox = {
    url = 'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
  },
  gruvbox_material = {
    url = 'sainnhe/gruvbox-material',
    name = 'gruvbox-material',
  },
  sonokai = {
    url = 'sainnhe/sonokai',
    name = 'sonokai',
    config = {
      sonokai_style = 'atlantis',
    },
  },
  ayu = {
    url = 'Shatur/neovim-ayu',
    name = 'ayu-dark',
  },
  doom_one = {
    url = 'NTBBloodbath/doom-one.nvim',
    name = 'doom-one',
  },
  despacio = {
    url = 'AlessandroYorba/Despacio',
    name = 'despacio',
    config = {
      espacio_Midnight = 1,
    },
  },
  falcon = {
    url = 'fenetikm/falcon',
    name = 'falcon',
    config = {
      falcon_background = 1,
      falcon_inactive = 1,
    },
  },
  edge = {
    url = 'sainnhe/edge',
    name = 'edge',
    config = {
      edge_enable_italic = true,
      edge_style = 'neon',
      edge_better_performance = 1,
    },
  },
}

M.set_theme = function(theme_name)
  local theme = M.themes[theme_name]
  if theme then
    M.current_theme = theme
    vim.cmd('colorscheme ' .. theme.name)
  else
    print("Theme not found: " .. theme_name)
  end
end

M.get_theme_specs = function()
  local spec_list = {}
  for _, theme in pairs(M.themes) do
    local spec = {
      theme.url,
      name = theme.name
    }
    if theme.config then
      spec.config = function()
        for option, value in pairs(theme.config) do
          vim.g[option] = value
        end
      end
    end
    table.insert(spec_list, spec)
  end
  return spec_list
end

vim.api.nvim_create_user_command('ThemeSwitch', function(opts)
  M.set_theme(opts.args)
end, { nargs = 1, complete = function()
  return vim.tbl_keys(M.themes)
end })

return M
