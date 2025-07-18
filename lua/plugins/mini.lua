return {
  -- Add mini nvim
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.surround').setup {}
    require('mini.starter').setup {
      header = os.date(),
    }
    require('mini.trailspace').setup {}
    require('mini.cursorword').setup {}
    require('mini.bufremove').setup {}
    require('mini.comment').setup {}

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
