local global = require('global')
local Utils = require('utils')
local map = Utils.map
local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')

-- Register the progress handler
lsp_status.register_progress()

-- Customize how diagnostics are updated and displayed
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true
})

-- Advertise to LSP servers that nvim-cmp supports LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Extended capabilities with lsp_status capabilities
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

-- Setup all settings when we attach to a buffer for an LSP
local function on_attach(client)
  lsp_status.on_attach(client)
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>zz', {buffer = true, silent = true})
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>zz', {buffer = true, silent = true})
  map('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', {buffer = true, silent = true})
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>zz', {buffer = true, silent = true})
  map('n', 'gs', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', {buffer = true, silent = true})
  map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {buffer = true, silent = true})
  map('n', 'gr', '<cmd>lua require("lspsaga.rename").rename()<CR>', {buffer = true, silent = true})
  map('n', '<leader>ca', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', {buffer = true, silent = true})
  map('v', '<leader>ca', '<cmd>lua require("lspsaga.codeaction").range_code_action()<CR>', {buffer = true, silent = true})
  map('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {buffer = true, silent = true})
  map('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>zz', {buffer = true, silent = true})
  map('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>zz', {buffer = true, silent = true})
  map('n', 'gh', '<cmd>lua require"lspsaga.provider".lsp_finder()<CR>', {buffer = true, silent = true})

  -- If LSP server supports document highlighting
  if client.resolved_capabilities.document_highlight == true then

    Utils.create_buf_augroup(
      {
        { 'CursorHold', 'lua vim.lsp.buf.document_highlight()' },
        { 'CursorHold', 'lua vim.lsp.diagnostic.show_line_diagnostics()' },
        { 'CursorMoved', 'lua vim.lsp.buf.clear_references()' },
      },
      'lsp_aucmds'
    )
  end

  -- Need to register LSP signature on attach,
  require "lsp_signature".on_attach({
    bind = true,
    handler_opts = {
      border = "single"
    }
  })
end

-- Setup sumneko root path
local sumneko_root_path = global.home .. "/bin/lua-language-server"

-- Setup sumneko binary path
local sumneko_binary
if global.is_linux or global.is_windows then
  sumneko_binary = sumneko_root_path .. "/bin/" .. global.os_name .. "/lua-language-server"
else
  if global.is_mac then
    sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
  end
end

-- Add lua directories to runtime path
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- List of LSP configure we want to configure with their configurations.
local lsp_servers = {

  clangd = {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern('compile_commands.json', 'compile_flags.txt', '.git'),
    handlers = lsp_status.extensions.clangd.setup(),
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true
    },
    single_file_support = true
  },

  cmake = {
    on_attach = on_attach,
    capabilities = capabilities,
    single_file_support = true
  },

  pyright = {
    on_attach = on_attach,
    capabilities = capabilities,
    single_file_support = true
  },

  sumneko_lua = {
    on_attach = on_attach,
    capabilities = capabilities,
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
    single_file_support = true
  },
}

-- Setup all LSP clients
for server, config in pairs(lsp_servers) do
  lspconfig[server].setup(config)
end
