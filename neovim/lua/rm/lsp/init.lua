require("telescope")

local default_capabilities = vim.tbl_deep_extend("force", require("blink.cmp").get_lsp_capabilities(), {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = false,
      },
    },
  },
})

vim.lsp.config("*", {
  root_markers = { ".git", ".nvim.lua" },
  capabilities = default_capabilities,
})

local lsp_servers = {
  "clangd",
  "lua_ls",
  "rust_analyzer",
  "yaml",
}

-- Log level
-- ~/.local/state/nvim/lsp.log
vim.lsp.set_log_level(vim.log.levels.WARN)

-- Close signature_help on following events
vim.lsp.buf.signature_help({
  border = "shadow",
  close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
})

vim.lsp.buf.hover({
  border = "shadow",
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true,
})

local hooks = {}

local lsp_rename = function()
  local curr_name = vim.fn.expand("<cword>")
  vim.ui.input({
    prompt = "LSP Rename: ",
    default = curr_name,
  }, function(new_name)
    if new_name then
      ---@diagnostic disable-next-line: missing-parameter
      local lsp_params = vim.lsp.util.make_position_params()

      if not new_name or #new_name == 0 or curr_name == new_name then
        return
      end

      -- request lsp rename
      ---@diagnostic disable-next-line: inject-field
      lsp_params.newName = new_name
      vim.lsp.buf_request(0, "textDocument/rename", lsp_params, function(_, res, ctx)
        if not res then
          return
        end

        --- @cast ctx lsp.HandlerContext

        -- apply renames
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if client then
          --- @cast client vim.lsp.Client
          vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

          -- print renames
          local changed_files_count = 0
          local changed_instances_count = 0

          if res.documentChanges then
            for _, changed_file in pairs(res.documentChanges) do
              changed_files_count = changed_files_count + 1
              changed_instances_count = changed_instances_count + #changed_file.edits
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
              "Renamed %s instance%s in %s file%s. %s",
              changed_instances_count,
              changed_instances_count == 1 and "" or "s",
              changed_files_count,
              changed_files_count == 1 and "" or "s",
              changed_files_count > 1 and "To save them run ':cfdo w'" or ""
            ),
            vim.log.levels.INFO
          )
        end
      end)
    end
  end)
end

---
---@param _ any a reference to the lsp client
---@param bufnr number the buffer number
hooks.my_on_attach = function(_, bufnr)
  vim.keymap.set({ "n" }, "gh", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })

  vim.keymap.set({ "n" }, "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP GoTo implementation" })

  vim.keymap.set({ "n" }, "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP GoTo Type" })

  vim.keymap.set({ "n" }, "gd", function()
    require("telescope.builtin").lsp_definitions()
  end, { buffer = bufnr, desc = "LSP GoTo Definition" })

  vim.keymap.set({ "n" }, "gD", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP GoTo Definition" })

  vim.keymap.set({ "n" }, "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP Signatute Help" })

  vim.keymap.set({ "n" }, "<leader>rn", lsp_rename, { buffer = bufnr, desc = "LSP Rename" })

  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP Code Action" })

  vim.keymap.set({ "n" }, "<leader>lr", function()
    require("telescope.builtin").lsp_references()
  end, { buffer = bufnr, desc = "LSP List References" })

  vim.keymap.set({ "n" }, '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, { buffer = bufnr, desc = "LSP Format" })

  vim.keymap.set({ "n" }, "<leader>li", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP GoTo Implementation" })

  vim.keymap.set({ "n" }, "<leader>ps", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols()
  end, { buffer = bufnr, desc = "LSP Dynamic Workspace Symbols" })

  vim.keymap.set({ "n" }, "<leader>lw", function()
    require("telescope.builtin").lsp_workspace_symbols()
  end, { buffer = bufnr, desc = "LSP Workspace Symbols" })

  vim.keymap.set({ "n" }, "<leader>gs", function()
    require("telescope.builtin").lsp_document_symbols()
  end, { buffer = bufnr, desc = "LSP Document Symbols" })
end

hooks.my_capabilities = vim.tbl_deep_extend("force", require("blink.cmp").get_lsp_capabilities(), {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = false,
      },
    },
  },
})

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
