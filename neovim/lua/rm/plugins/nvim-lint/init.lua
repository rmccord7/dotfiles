local events = {
  'BufReadPost',
  'BufWritePost',
  'InsertLeave',
  -- 'FileReadPost',
  -- 'TextChanged',
  -- 'ModeChanged',
  -- 'FocusGained',
}

return {
  'mfussenegger/nvim-lint',
  event = events,
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      lua = { 'selene' },
      python = { 'ruff' },
    }

    vim.api.nvim_create_autocmd(events, {
      callback = function()
        lint.try_lint()
      end,
    })

    local linters = {
      'ruff',
      'selene',
    }

    for _, linter in ipairs(linters) do
      local ns = lint.get_namespace(linter)
      vim.diagnostic.config(
        vim.tbl_deep_extend('force', vim.diagnostic.config(), {
          virtual_text = {
            suffix = ' ⁅' .. linter .. '⁆',
          },
        }),
        ns
      )
    end
  end,
}
