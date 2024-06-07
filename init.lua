--[[
2024-02-04 12:08

r00t nvim
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.colorschemes = {
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
      sonokai_style = 'atlantis'
    }
  },
  ayu = {
    url = 'Shatur/neovim-ayu',
    name = 'ayu-dark'
  },
  doom_one = {
    url = 'NTBBloodbath/doom-one.nvim',
    name = 'doom-one'
  },
  despacio = {
    url = 'AlessandroYorba/Despacio',
    name = 'despacio',
    config = {
      espacio_Midnight = 1
    }
  },
  falcon = {
    url = 'fenetikm/falcon',
    name = 'falcon',
    config = {
      falcon_background = 1,
      falcon_inactive = 1
    }
  }
}

vim.g.theme = vim.g.colorschemes.gruvbox_material

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local disable_builtin_plugins = {
  'netrwPlugin',
  'gzip',
  'tutor',
  'tohtml'
}

-- [[ Configure plugins ]]
require('lazy').setup({
  spec = {
    -- Git related plugins
    {
      'tpope/vim-fugitive',
      event = "VeryLazy"
    },

    -- Detect tabstop and shiftwidth automatically
    {
      'tpope/vim-sleuth',
      event = "VeryLazy"
    },

    -- Import all plugins in lua/plugins
    { import = 'plugins' },
  },
  install = {
    missing = true,
    colorscheme = { vim.g.theme.name, 'habamax' },
  },
})
