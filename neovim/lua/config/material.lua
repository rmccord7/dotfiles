-- Example config in lua
vim.g.material_style = 'deep ocean'

require('material').setup({
  custom_colors = {
    fg = '#717CB4',
    comments = '#5A6077',
    line_numbers = '#5A6077'
  }
})

vim.cmd[[colorscheme material]]
