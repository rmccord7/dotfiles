local bufnr = vim.api.nvim_get_current_buf()

if vim.b[bufnr].rm_did_ftplugin then
  return
end

vim.b[bufnr].rm_did_ftplugin = true

-- Buffer options
vim.bo.autoindent = true  -- Insert indents automatically
vim.bo.expandtab = true   -- Expands tabs to spaces
vim.bo.shiftwidth = 4     -- Size of an indent
vim.bo.smartindent = true -- Insert indents automatically
vim.bo.softtabstop = 4    -- Number of spaces tabs count for
vim.bo.tabstop = 4        -- Number of spaces in a tab

-- Map to align C variable declarations by both identifier and = when visually
-- selected
vim.keymap.set({ "x" }, '<leader>ad', 'gadgvga=', { desc = 'Align c style variables' })

-- https://github.com/neovim/neovim/issues/33577
-- https://github.com/neovim/neovim/pull/33579
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "clangd" then
            require("rm.lsp.defaults").on_attach(client, bufnr)
        end
    end,
})
