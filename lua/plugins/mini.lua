local header_gen = function()
  local function get_git_info()
    local git_branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("\n", "")
    local git_status = ""

    if vim.v.shell_error == 0 and git_branch ~= "" then
      -- Get git status info
      local status_output = vim.fn.system("git status --porcelain 2>/dev/null")
      local changes = vim.split(status_output, "\n")
      local modified = 0
      local added = 0
      local deleted = 0

      for _, line in ipairs(changes) do
        if line ~= "" then
          local status = line:sub(1, 2)
          if status:match("M") then modified = modified + 1 end
          if status:match("A") then added = added + 1 end
          if status:match("D") then deleted = deleted + 1 end
        end
      end

      if modified + added + deleted > 0 then
        git_status = string.format(" (+%d ~%d -%d)", added, modified, deleted)
      else
        git_status = " ✓"
      end

      return string.format("🌿 %s%s", git_branch, git_status)
    else
      return ""
    end
  end

  return string.format([[
─────────────────────────
 Neovim v%s
 Welcome to %s
 %s
 📁 %s
 %s
─────────────────────────]],
    vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
    vim.loop.os_gethostname(),
    os.date("%Y-%m-%d %H:%M:%S"),
    vim.fn.fnamemodify(vim.fn.getcwd(), ':t'),
    get_git_info()
  )
end

return {
  -- Add mini nvim
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    require('mini.surround').setup {}
    require('mini.snippets').setup {}
    require('mini.starter').setup {
      header = header_gen()
    }
    require('mini.git').setup {}
    require('mini.trailspace').setup {}
    require('mini.cursorword').setup {}
    require('mini.bufremove').setup {}
    require('mini.comment').setup {}
    require('mini.completion').setup {}

    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    local hipatterns = require('mini.hipatterns')
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })

    local indentscope = require 'mini.indentscope'
    indentscope.setup {
      draw = {
        delay = 10,
        animation = indentscope.gen_animation.quadratic {
          easing = 'in',
          duration = 15,
          unit = 'step',
        },
      },
      symbol = '│',
    }
  end,
}
