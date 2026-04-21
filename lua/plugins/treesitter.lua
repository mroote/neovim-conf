local ensure_installed = {
  'c',
  'cpp',
  'go',
  'lua',
  'python',
  'rust',
  'tsx',
  'javascript',
  'typescript',
  'vim',
  'bash',
  'terraform',
  'yaml',
  'json',
  'html',
  'elixir',
  'markdown',
  'markdown_inline',
  -- 'vimdoc' is installed for the 'help' filetype (mapped below)
  'vimdoc',
}

-- Parser names that don't match their filetype 1:1
local parser_to_ft = {
  vimdoc = 'help',
}

-- Build the filetype list for the FileType autocmd
-- markdown_inline is injected; it has no standalone filetype
local ft_patterns = {}
for _, parser in ipairs(ensure_installed) do
  if parser ~= 'markdown_inline' then
    local ft = parser_to_ft[parser] or parser
    table.insert(ft_patterns, ft)
  end
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      local installed = require('nvim-treesitter.config').get_installed()
      local to_install = vim.tbl_filter(
        function(p) return not vim.list_contains(installed, p) end,
        ensure_installed
      )
      if #to_install > 0 then
        require('nvim-treesitter').install(to_install)
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = ft_patterns,
        callback = function(args)
          vim.treesitter.start()
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local sel  = require('nvim-treesitter-textobjects.select')
      local mov  = require('nvim-treesitter-textobjects.move')
      local swap = require('nvim-treesitter-textobjects.swap')

      for lhs, capture in pairs({
        aa = '@parameter.outer',
        ia = '@parameter.inner',
        af = '@function.outer',
        ['if'] = '@function.inner',
        ac = '@class.outer',
        ic = '@class.inner',
      }) do
        vim.keymap.set({ 'x', 'o' }, lhs, function()
          sel.select_textobject(capture, 'textobjects')
        end)
      end

      vim.keymap.set({ 'n', 'x', 'o' }, ']m',  function() mov.goto_next_start('@function.outer',     'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']]',  function() mov.goto_next_start('@class.outer',        'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']M',  function() mov.goto_next_end('@function.outer',       'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '][',  function() mov.goto_next_end('@class.outer',          'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[m',  function() mov.goto_previous_start('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[[',  function() mov.goto_previous_start('@class.outer',    'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[M',  function() mov.goto_previous_end('@function.outer',   'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[]',  function() mov.goto_previous_end('@class.outer',      'textobjects') end)

      vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner')     end)
      vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end)
    end,
  },
}
