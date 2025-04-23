vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--log=verbose',
    '--pretty',
    '--background-index',
    '-j=8',
    '--inlay-hints',
    -- "--malloc-trim",
    '--pch-storage=memory',
    '--header-insertion=never',
    '--header-insertion-decorators',
    '--all-scopes-completion',
    -- "--clang-tidy",
    -- "--clang-tidy-checks=modernize-*,misc-*"
    '--function-arg-placeholders',
    '--completion-style=detailed',
  },
})
