local Utils = require('utils')
local map = Utils.map

local servers = {
  'bashls',
  'clangd',
  'cmake',
  'null-ls',
  --'pylsp',
  'pyright',
  'rust-analyzer',
  'sumneko_lua'
}

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

-- Setup all settings when we attach to a buffer for an LSP
local function on_attach(client)
  map('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format()<CR>', {buffer = true, silent = true})
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
  if client.server_capabilities.documentHighlight == true then

    Utils.create_buf_augroup(
      'LSP_AUCMDS',
      {
        { {'CursorHold'}, 'lua vim.lsp.buf.document_highlight()' },
        { {'CursorHold'}, 'lua vim.diagnostic.open_float({scope="line"})' },
        { {'CursorMoved'}, 'lua vim.lsp.buf.clear_references()' },
      },
      0
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

local ok, _ = pcall(require, "lspconfig")

if ok then
    for _, server in ipairs(servers) do
        require("config.lsp.servers." .. server).setup(on_attach, capabilities)
    end
end

