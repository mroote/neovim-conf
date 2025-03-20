local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function min_window_width(width)
  return function() return vim.fn.winwidth(0) > width end
end

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  event = 'VeryLazy',
  opts = {
    options = {
      icons_enabled = true,
      theme = vim.g.theme,
      globalstatus = false,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        'packer',
        'neo-tree',
        'toggleterm',
        'winbar',
        'Avante',
      },
    },
    sections = {
      lualine_b = {
        {
          'branch',
          cond = min_window_width(60),
        },
        {
          'diff',
          source = diff_source,
          cond = min_window_width(80),
        },
      },
      lualine_c = {
        {
          'filename',
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_x = {
        {
          'filetype',
          -- Override 'encoding': Don't display if encoding is UTF-8.
          encoding = function()
            local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
            return ret
          end,
          -- fileformat: Don't display if &ff is unix.
          fileformat = function()
            local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
            return ret
          end
        },
      },
      lualine_z = {
        {
          'location',
          cond = min_window_width(90)
        },
      },
    },
  },
}
