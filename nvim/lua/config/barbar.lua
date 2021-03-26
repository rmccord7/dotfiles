vim.api.nvim_exec(
[[
let bufferline = get(g:, 'bufferline', {})
let bufferline.icon_separator_active = '|'
let bufferline.icon_separator_inactive = '|'
]],
false)
