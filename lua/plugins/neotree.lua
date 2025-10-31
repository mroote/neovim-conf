return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    default_component_configs = {
      indent = {
        indent_size = 1,
      },
      file_size = {
        enabled = false
      },
      last_modified = {
        enabled = false
      },
    },
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    filesystem = {
      follow_current_file = {
        enabled = true
      },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
