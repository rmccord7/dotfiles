local lspconfig = require('lspconfig')

local nvim_config = require('rm.config')
local util_path = require('rm.util.path')

-- Add lua directories to runtime path that is supplied to the LSP
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- Additional Workspace files when working with lua
local library_files = {
  vim.api.nvim_get_runtime_file('', true),
  -- util_path.os_path(vim.fn.expand('~/dotfiles/neovim/lua')),
  -- util_path.os_path(vim.fn.expand(nvim_config.path.plugins .. '/telescope.nvim/lua')), -- Go to telescope definitions
}

local M = {}

function M.setup(hooks)
  lspconfig.lua_ls.setup({

    on_attach = hooks.my_on_attach,
    capabilities = hooks.my_capabilities,

    cmd = { -- Command to start the language server.
      'lua-language-server',
      '--logpath=' .. util_path.os_path(nvim_config.path.nvim_log .. '/lsp/lua'),
      '--loglevel=debug',
      '--metapath',
      vim.fn.stdpath('cache') .. '/lua-language-server/meta/',
    },

    filetypes = {
      'lua',
    },

    settings = {
      Lua = {
        runtime = { -- Lua runtime
          version = 'LuaJIT', -- Use neovim LUAJIT runtime
          path = runtime_path, -- Point to neovim runtime
        },
        diagnostics = {
          globals = { -- Ignore missing globals
            'vim', -- Ignore Neovim missing vim global
            -- 'package', -- Ignore Neovim missing package
          },
          disable = { -- Disable diagnostics
            'lowercase-global', -- Disable global variable not capitilized
          },
        },
        workspace = { -- External workspace
          checkThirdParty = false, -- Look for external lua modules
          library = library_files, -- Point to external lua modules
        },
      },
    },

    commands = { -- LSP commands
      Format = { -- LSP format command
        -- Format the lua buffer using the stylua-nvim plugin.
        function()
          require('stylua-nvim').format_file()
        end,
      },
    },
  })
end

return M
