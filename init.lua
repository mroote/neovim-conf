--[[
2024-02-04 12:08

r00t nvim
--]]

local themes = require('themes')

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.theme = themes.themes.sonokai

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
  'tohtml',
}

-- [[ Configure plugins ]]
require('lazy').setup {
  spec = {
    unpack(themes.get_theme_specs()),
    -- Git related plugins
    {
      'tpope/vim-fugitive',
      event = 'VeryLazy',
    },

    -- Detect tabstop and shiftwidth automatically
    {
      'tpope/vim-sleuth',
      event = 'VeryLazy',
    },

    -- Import all plugins in lua/plugins
    { import = 'plugins' },
  },
  install = {
    missing = true,
    colorscheme = { vim.g.theme.name, 'habamax' },
  },
}
