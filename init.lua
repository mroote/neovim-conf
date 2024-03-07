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
  }
}

vim.g.theme = vim.g.colorschemes.sonokai

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

-- [[ Configure plugins ]]
require('lazy').setup({
  spec = {
    -- Git related plugins
    'tpope/vim-fugitive',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Import all plugins in lua/plugins
    { import = 'plugins' },
  },
  install = {
    missing = true,
    colorscheme = { vim.g.theme.name },
  },
})

