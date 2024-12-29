return {
  'mfussenegger/nvim-lint',
  config = function(_, _)
    local lint_group = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({
      'FileReadPost',
      'InsertLeave',
      'BufWritePost',
      'TextChanged',
      'ModeChanged',
      'FocusGained',
    }, {
      group = lint_group,
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
