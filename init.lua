--[[
2024-02-04 12:08

r00t nvim
--]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.theme = 'gruvbox-material'

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
require('lazy').setup {
  spec = {
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
    colorscheme = { vim.g.theme, 'habamax' },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
      },
    },
  },
}
