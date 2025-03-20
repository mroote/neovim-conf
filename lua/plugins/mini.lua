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
    -- require('mini.notify').setup {}
    local indentscope = require 'mini.indentscope'
    indentscope.setup {
      draw = {
        delay = 50,
        animation = indentscope.gen_animation.quadratic {
          easing = 'in',
          duration = 5,
          unit = 'step',
        },
      },
      symbol = '│',
    }
  end,
}
