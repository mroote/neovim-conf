-- Enable language servers
local servers = {
  arduino_language_server = {},
  clangd = {},
  gopls = {
    cmd = { 'gopls', 'serve' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl', '.yaml' },
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
    root_dir = function(fname)
      -- see: https://github.com/neovim/nvim-lspconfig/issues/804
      local util = require 'lspconfig.util'
      return util.root_pattern 'go.work' (fname) or util.root_pattern('go.mod', '.git')(fname)
    end,
  },
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "off",
        },
      }
    },
  },
  bashls = {},
  ansiblels = {},
  dockerls = {},
  docker_compose_language_service = {},
  jsonls = {},
  terraformls = {},
  elixirls = {
    settings = {
      dialyzerEnabled = false,
    }
  },
  yamlls = {},
  html = {
    filetypes = { 'html', 'twig', 'hbs' },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
  systemd_ls = {},
}

local linters = {
  actionlint = {},
  gitleaks = {},
  gitlint = {},
  luacheck = {},
  systemdlint = {},
}

local debuggers = {
  python = {},
}

return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {
      'williamboman/mason.nvim',
      event = 'VeryLazy',
      config = true,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      event = 'VeryLazy',
    },
    {
      'jay-babu/mason-nvim-dap.nvim',
      event = 'VeryLazy',
      dependencies = {
        {
          'mfussenegger/nvim-dap',
        },
      },
    },
    -- Useful status updates for LSP
    {
      'j-hui/fidget.nvim',
      event = 'VeryLazy',
    },
    -- Additional lua configuration, makes nvim stuff amazing!
    {
      'folke/lazydev.nvim',
      opts = {},
      event = 'VeryLazy',
    },
    -- Add ansible-vim for filetype detection
    {
      'pearofducks/ansible-vim',
      event = 'VeryLazy',
    },
  },
  config = function()
    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- easily define mappings specific for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', function()
        vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
      end, '[C]ode [A]ction')
      nmap('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
      nmap('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
      nmap('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
      nmap('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    vim.diagnostic.config {
      virtual_text = false,
      underline = false
    }

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require('mason').setup {
      log_level = vim.log.levels.DEBUG,
    }

    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(servers)
    }

    -- setup debugging config
    require('mason-nvim-dap').setup {
      ensure_installed = vim.tbl_keys(debuggers),
    }

    for server_name, config in pairs(servers) do
      vim.lsp.config(server_name, {
        capabilities = (config or {}).capabilities,
        on_attach = on_attach,
        cmd = (config or {}).cmd,
        settings = (config or {}).settings,
        filetypes = (config or {}).filetypes,
        root_dir = (config or {}).root_dir,
      })
    end
  end,
}
