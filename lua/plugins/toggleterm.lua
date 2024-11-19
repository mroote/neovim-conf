return {
  -- Add toggleterm
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VeryLazy',
  opts = {
    persist_size = false,
  },
  config = function()
    require('toggleterm').setup()
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new {
      cmd = 'lazygit',
      dir = 'git_dir',
      direction = 'float',
      float_opts = {
        border = 'double',
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd 'startinsert!'
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function()
        vim.cmd 'startinsert!'
      end,
    }

    function lazygit_toggle()
      lazygit:toggle()
    end

    local aider = Terminal:new {
      cmd = 'aider',
      direction = 'vertical',
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd 'startinsert!'
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function()
        vim.cmd 'startinsert!'
      end,
    }

    function aider_toggle()
      aider:toggle()
    end

    vim.api.nvim_set_keymap('n', '<leader>gt', '<cmd>lua lazygit_toggle()<CR>', {
      noremap = true,
      silent = true,
      desc = 'Open lazygit window',
    })
    vim.api.nvim_set_keymap('n', '<leader>ga', '<cmd>lua aider_toggle()<CR>', {
      noremap = true,
      silent = true,
      desc = 'Open aider window',
    })
    vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<cr>', {
      noremap = true,
      silent = true,
      desc = 'Open terminal',
    })
  end,
}
