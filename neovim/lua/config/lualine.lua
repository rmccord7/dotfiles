require'nvim-web-devicons'.setup{}

require('lualine').setup{
  options = {
    theme = 'material-nvim',
    section_separators = {'', ''},
    component_separators = {'', ''},
    icons_enabled = true,
  },
  sections = {
    lualine_a = { {'mode', upper = true} },
    lualine_b = { {'branch', icon = ''} },
    lualine_c = { {'filename', file_status = true} },
    lualine_x = { {'diagnostics', sources = {'nvim_lsp'}, color_error = '#FF3737', color_warn = '#FAD200', color_info = '#55AAFF'} },
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
