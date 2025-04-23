require('telescope')

-- Log level
-- ~/.local/state/nvim/lsp.log
vim.lsp.set_log_level(vim.log.levels.WARN)

-- Close signature_help on following events
vim.lsp.buf.signature_help({
  border = 'shadow',
  close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
})

vim.lsp.buf.hover({
  border = 'shadow',
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
})

-- Configure LSP server defaults.
require('rm.lsp.defaults')

-- Configure each LSP server.
local lsp_servers = {
  'clangd',
  'lua_ls',
  'rust_analyzer',
  'yaml',
}

for _, server in ipairs(lsp_servers) do
  require('rm.lsp.config.' .. server)
end

-- Enable the LSP servers.
vim.lsp.enable(lsp_servers)
