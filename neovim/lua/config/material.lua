-- Example config in lua
vim.g.material_style = 'deep ocean'
vim.g.material_italic_comments = false
vim.g.material_italic_keywords = false
vim.g.material_italic_functions = false
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = false
vim.g.material_disable_background = false

-- Load the colorscheme
require('material').set()
