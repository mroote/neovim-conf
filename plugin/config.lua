-- [[ Setting options ]]

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- disable line wrapping
vim.o.wrap = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.showmatch = true

vim.o.termguicolors = true

-- Check for changes in file outside of vim
vim.o.autoread = true

-- [[ Autoread configuration ]]
-- Trigger checktime when files change on disk
local autoread_group = vim.api.nvim_create_augroup('AutoRead', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = autoread_group,
  pattern = '*',
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd('checktime')
    end
  end,
})

-- Notification after file change
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = autoread_group,
  pattern = '*',
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ JSON file settings ]]
-- Set indentation to 2 spaces for JSON files
local json_group = vim.api.nvim_create_augroup('JsonSettings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = json_group,
  pattern = 'json',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('gotmpl_highlight', { clear = true }),
  pattern = '*.tmpl',
  callback = function()
    local filename = vim.fn.expand('%:t')
    local ext = filename:match('.*%.(.-)%.tmpl$')

    -- Add more extension to syntax mappings here if you need to.
    local ext_filetypes = {
      go = 'go',
      html = 'html',
      md = 'markdown',
      yaml = 'yaml',
      yml = 'yaml',
    }

    if ext and ext_filetypes[ext] then
      -- Set the primary filetype
      vim.bo.filetype = ext_filetypes[ext]

      -- Define embedded Go template syntax
      vim.cmd([[
        syntax include @gotmpl syntax/gotmpl.vim
        syntax region gotmpl start="{{" end="}}" contains=@gotmpl containedin=ALL
        syntax region gotmpl start="{%" end="%}" contains=@gotmpl containedin=ALL
      ]])
    end
  end,
})
