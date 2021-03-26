require'nvim-web-devicons'.setup{}

require('lualine').setup{
  options = {
    theme = 'auto',
    section_separators = {'', ''},
    component_separators = {'', ''},
    icons_enabled = true,
  },
  sections = {
    lualine_a = { {'mode', upper = true} },
    lualine_b = { {'branch', icon = ''} },
    lualine_c = { {'filename', file_status = true} },
    lualine_x = { {'diagnostics', sources = {'nvim_lsp'}} },
    lualine_y = { 'encoding', 'fileformat', 'filetype' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {  },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {  },
    lualine_z = {  }
  }
}
