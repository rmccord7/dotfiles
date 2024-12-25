local config = function()
  local ok, plugin = pcall(require, "trouble")

  if not ok then
    return
  end

  plugin.setup()

  -- vim.keymap.set({"n"}, '<leader>xx', ':Trouble<CR>', { desc = 'Trouble toggle' })
  -- vim.keymap.set({"n"}, '<leader>xw', ':Trouble workspace_diagnostics<CR>', { desc = 'Trouble workspace diagnostics' })
  -- vim.keymap.set({"n"}, '<leader>xd', ':Trouble document_diagnostics<CR>', { desc = 'Trouble document diagnostics' })
  -- vim.keymap.set({"n"}, '<leader>xq', ':Trouble quickfix<CR>', { desc = 'Trouble quickfix' })
  -- vim.keymap.set({"n"}, '<leader>xl', ':Trouble loclist<CR>', { desc = 'Trouble loclist' })
  -- vim.keymap.set({"n"}, '<leader>xr', ':Trouble lsp_references<CR>', { desc = 'Trouble LSP Ref' })
  -- vim.keymap.set({"n"}, '<leader>xn', [[:lua require('trouble').next({skip_groups = false, jump = true})<CR>]], { desc = 'Trouble Next' })
  -- vim.keymap.set({"n"}, '<leader>xp', [[:lua require('trouble').previous({skip_groups = false, jump = true})<CR>]], { desc = 'Trouble Previous' })
end

local M = {
  {
    "folke/trouble.nvim",
    config = config,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
  },
}

return M
