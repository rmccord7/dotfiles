Utils = require('Utils')

local servers = {
  'bashls',
  'clangd',
  'cmake',
  --'null-ls',
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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup all settings when we attach to a buffer for an LSP
local function on_attach(client, bufnr)

  nmap('<leader>fm', ':lua vim.lsp.buf.format()<CR>', nil, {buffer = bufnr})
  nmap('gD', ':lua vim.lsp.buf.declaration()<CR>zz', nil, {buffer = bufnr})
  nmap('gd', ':lua vim.lsp.buf.definition()<CR>zz', nil, {buffer = bufnr})
  nmap('K', ':lua require("lspsaga.hover").render_hover_doc()<CR>', nil, {buffer = bufnr})
  nmap('gi', ':lua vim.lsp.buf.implementation()<CR>zz', nil, {buffer = bufnr})
  nmap('gs', ':lua require("lspsaga.signaturehelp").signature_help()<CR>', nil, {buffer = bufnr})
  nmap('<leader>D', ':lua vim.lsp.buf.type_definition()<CR>', nil, {buffer = bufnr})
  nmap('gr', ':lua require("lspsaga.rename").rename()<CR>', nil, {buffer = bufnr})
  nmap(':Lspsaga code_action<CR>', '<leader>ca', nil, {buffer = bufnr})
  vmap('<leader>ca', ':lua require("lspsaga.codeaction").range_code_action()<CR>', nil, {buffer = bufnr})
  nmap('<leader>q', ':lua vim.lsp.diagnostic.set_loclist()<CR>', nil, {buffer = bufnr})
  nmap(']e', ':Lspsaga diagnostic_jump_next<CR>zz', nil, {buffer = bufnr})
  nmap('[e', ':Lspsaga diagnostic_jump_prev<CR>zz', nil, {buffer = bufnr})
  nmap('gh', ':lua require("lspsaga.finder").lsp_finder()<CR>', nil, {buffer = bufnr})

  -- If LSP server supports document highlighting
  if client.server_capabilities.documentHighlight == true then

    Utils.create_buf_augroup(
      'LSP_AUCMDS',
      {
        { {'CursorHold'}, 'lua vim.lsp.buf.document_highlight()' },
        { {'CursorHold'}, 'lua vim.diagnostic.open_float({scope="line"})' },
        { {'CursorMoved'}, 'lua vim.lsp.buf.clear_references()' },
      },
      bufnr
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
    require("neodev").setup{}

    for _, server in ipairs(servers) do
        require("config.lsp.servers." .. server).setup(on_attach, capabilities)
    end
end

