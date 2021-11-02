local global = require('global')
local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')
local lspkind = require('lspkind')

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = global.home .. "/bin/lua-language-server"

local sumneko_binary
if global.is_linux or global.is_windows then
  sumneko_binary = sumneko_root_path .. "/bin/" .. global.os_name .. "/lua-language-server"
else
  if global.is_mac then
    sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
  end
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local kind_symbols = {
  Text = '',
  Method = 'Ƒ',
  Function = 'ƒ',
  Constructor = '',
  Variable = '',
  Class = '',
  Interface = 'ﰮ',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '了',
  Keyword = '',
  Snippet = '﬌',
  Color = '',
  File = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = ''
}

local sign_define = vim.fn.sign_define
sign_define('LspDiagnosticsSignError', {text = '', numhl = 'RedSign'})
sign_define('LspDiagnosticsSignWarning', {text = '', numhl = 'YellowSign'})
sign_define('LspDiagnosticsSignInformation', {text = '', numhl = 'WhiteSign'})
sign_define('LspDiagnosticsSignHint', {text = '', numhl = 'BlueSign'})
lsp_status.config {
  kind_labels = kind_symbols,
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ['start'] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[1])},
        ['end'] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[2])}
      }

      return require('lsp-status/util').in_range(cursor_pos, value_range)
    end
  end,
  current_function = false
}

lsp_status.register_progress()
lspkind.init {symbol_map = kind_symbols}
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true
})

local function on_attach(client)
  lsp_status.on_attach(client)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gs', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua require("lspsaga.rename").rename()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ca', '<cmd>lua require("lspsaga.codeaction").code_action()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'v', '<leader>ca', '<cmd>lua require("lspsaga.codeaction").range_code_action()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'cd', '<cmd>require"lspsaga.diagnostic".show_line_diagnostics()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_buf_set_keymap(0, 'n', ']e', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_buf_set_keymap(0, 'n', '[e', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', ']e', '<cmd>Lspsaga diagnostic_jump_next<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gh', '<cmd>lua require"lspsaga.provider".lsp_finder()<cr>', {noremap = true, silent = true})

  if client.resolved_capabilities.document_highlight == true then
    vim.cmd('augroup lsp_aucmds')
    vim.cmd('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
    vim.cmd('au CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()')
    vim.cmd('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
    vim.cmd('augroup END')
  end

  require "lsp_signature".on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "single"
        }
  })
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
  clangd = {
    root_dir = lspconfig.util.root_pattern('compile_commands.json', 'compile_flags.txt', '.git'),
    handlers = lsp_status.extensions.clangd.setup(),
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true
    }
  },
  cmake = {},
  pyright = {},
  sumneko_lua = {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    root_dir = lspconfig.util.root_pattern('.git'),
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  },
}

for server, config in pairs(servers) do
  config.on_attach = on_attach
  config.capabilities = vim.tbl_deep_extend('keep', config.capabilities or {},
                                            lsp_status.capabilities,
                                            capabilities)
  lspconfig[server].setup(config)
end
