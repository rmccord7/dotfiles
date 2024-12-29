local M = {
  extension = {
    h = 'c',
    scons = 'python',
    api = 'python',
    dh = 'dh',
  },
  filename = {
    ['.clangd'] = 'yaml',
  },
  pattern = {
    ['.*/sway/config%.d/.*'] = { 'swayconfig', priority = 10 },
  },
}

-- Add new file type mappings
vim.filetype.add(M)

return M
