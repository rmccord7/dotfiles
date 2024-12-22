require("telescope")

local lsp_servers = {
    "clangd",
    "lua_ls",
    "rust_analyzer",
    "yaml",
}

-- Log level
vim.lsp.set_log_level(vim.log.levels.WARN)

-- close signature_help on following events
vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'shadow',
    close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
  })

-- handle hover
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'shadow',
})

 vim.diagnostic.config({
     virtual_text = false,
     virtual_lines = true,
})


-- Global diagnostic actions regardless of LSP
nmap('<leader>e', vim.diagnostic.open_float, 'List Diagnostics')
nmap('[d', vim.diagnostic.goto_prev, 'GoTo Previous Diagnostic')
nmap(']d', vim.diagnostic.goto_next, 'GoTo Next Diagnostic')
-- nmap('<space>q', vim.diagnostic.setloclist, 'Set Loc List With Diagnostics')

local hooks = {}

lsp_rename = function()
  local curr_name = vim.fn.expand '<cword>'
  vim.ui.input({
    prompt = 'LSP Rename: ',
    default = curr_name,
  }, function(new_name)
    if new_name then
      ---@diagnostic disable-next-line: missing-parameter
      local lsp_params = vim.lsp.util.make_position_params()

      if not new_name or #new_name == 0 or curr_name == new_name then
        return
      end

      -- request lsp rename
      lsp_params.newName = new_name
      vim.lsp.buf_request(
        0,
        'textDocument/rename',
        lsp_params,
        function(_, res, ctx, _)
          if not res then
            return
          end

          -- apply renames
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

          -- print renames
          local changed_files_count = 0
          local changed_instances_count = 0

          if res.documentChanges then
            for _, changed_file in pairs(res.documentChanges) do
              changed_files_count = changed_files_count + 1
              changed_instances_count = changed_instances_count
                + #changed_file.edits
            end
          elseif res.changes then
            for _, changed_file in pairs(res.changes) do
              changed_instances_count = changed_instances_count + #changed_file
              changed_files_count = changed_files_count + 1
            end
          end

          -- compose the right print message
          vim.notify(
            string.format(
              'Renamed %s instance%s in %s file%s. %s',
              changed_instances_count,
              changed_instances_count == 1 and '' or 's',
              changed_files_count,
              changed_files_count == 1 and '' or 's',
              changed_files_count > 1 and "To save them run ':cfdo w'" or ''
            ),
            vim.log.levels.INFO
          )
        end
      )
    end
  end)
end

---
---@param _ any a reference to the lsp client
---@param bufnr number the buffer number
hooks.my_on_attach = function(_, bufnr)

    nmap('gh', vim.lsp.buf.hover, 'LSP Hover', { buffer = bufnr })
    nmap('gi', vim.lsp.buf.implementation, 'LSP GoTo implementation', { buffer = bufnr })
    nmap('gt', vim.lsp.buf.type_definition, 'LSP GoTo Type', { buffer = bufnr })
    nmap('gd', function() require('telescope.builtin').lsp_definitions() end, 'LSP GoTo Definition', { buffer = bufnr })
    nmap('gD', vim.lsp.buf.definition, 'LSP GoTo Definition', { buffer = bufnr })
    nmap('<C-s>', vim.lsp.buf.signature_help, 'LSP Signatute Help', { buffer = bufnr })
    nmap('<leader>rn', lsp_rename, 'LSP Rename', { buffer = bufnr })

    nmap('<leader>ca', vim.lsp.buf.code_action, 'LSP Code Action', { buffer = bufnr })
    vmap('<leader>ca', vim.lsp.buf.code_action, 'LSP Code Action', { buffer = bufnr })

    nmap('<leader>lr', function() require('telescope.builtin').lsp_references() end, 'LSP List References', { buffer = bufnr })
    nmap('<leader>f', function() vim.lsp.buf.format { async = true } end, 'LSP Format', { buffer = bufnr })

    nmap('<leader>li', vim.lsp.buf.implementation, 'LSP GoTo Implementation', { buffer = bufnr })

    nmap('<leader>ps', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, 'LSP Dynamic Workspace Symbols', { buffer = bufnr })
    nmap('<leader>lw', function() require('telescope.builtin').lsp_workspace_symbols() end, 'LSP Workspace Symbols', { buffer = bufnr })
    nmap('<leader>gs', function() require('telescope.builtin').lsp_document_symbols() end, 'LSP Document Symbols', { buffer = bufnr })
end

hooks.my_capabilities = vim.tbl_deep_extend(
  'force',
  require('blink.cmp').get_lsp_capabilities(),
  {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false,
        },
      },
    },
  }
)

-- local capabilities_without_formatting =
--   vim.tbl_deep_extend('force', hooks.my_capabilities, {
--     textDocument = {
--       formatting = false,
--       rangeFormatting = false,
--     },
--   })
--

for _, server in ipairs(lsp_servers) do
    require("rm.lsp.config." .. server).setup(hooks)
end
