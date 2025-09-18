return {
  "ibhagwan/fzf-lua",
  event = 'VeryLazy',
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  config = function()
    -- Function to find the git root directory based on the current buffer's path
    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()
      -- If the buffer is not associated with a file, return nil
      if current_file == '' then
        current_dir = cwd
      else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
      end

      -- Find the Git root directory from the current file's path
      local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
      if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
      end
      return git_root
    end

    -- Custom live_grep function to search in git root
    local function live_grep_git_root()
      local git_root = find_git_root()
      if git_root then
        require('fzf-lua').live_grep {
          cwd = git_root,
        }
      end
    end

    local function fzf_live_grep_open_files()
      require('fzf-lua').live_grep {
        grep_open_files = true,
        prompt = 'Live Grep in Open Files❯ ',
      }
    end

    require('fzf-lua').setup {
      winopts = {
        height = 0.85,
        width = 0.80,
        border = "rounded",
        preview = {
          border = "rounded",
          wrap = false,
          layout = "flex"
        }
      },
      keymap = {
        builtin = {
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          ["<F3>"] = "toggle-preview-wrap"
        },
        fzf = {
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-d"] = "half-page-down"
        }
      },
      actions = {
        files = {
          ["enter"] = require('fzf-lua.actions').file_edit_or_qf,
          ["ctrl-s"] = require('fzf-lua.actions').file_split,
          ["ctrl-v"] = require('fzf-lua.actions').file_vsplit
        }
      }
    }

    vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

    -- See `:help fzf-lua`
    vim.keymap.set('n', '<leader>?', require('fzf-lua').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('fzf-lua').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>s/', fzf_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
    vim.keymap.set('n', '<leader>sG', live_grep_git_root, { desc = '[S]earch by [G]rep on Git Root' })
    vim.keymap.set('n', '<leader>ss', require('fzf-lua').builtin, { desc = '[S]earch [S]elect FzfLua' })
    vim.keymap.set('n', '<leader>gf', require('fzf-lua').git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', require('fzf-lua').files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', require('fzf-lua').help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', require('fzf-lua').grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('fzf-lua').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', require('fzf-lua').diagnostics_document, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', require('fzf-lua').resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>/', function()
      require('fzf-lua').blines {
        winopts = {
          height = 0.4,
          width = 0.8,
          preview = {
            hidden = "hidden"
          }
        }
      }
    end, { desc = '[/] Fuzzily search in current buffer' })
  end,
}
