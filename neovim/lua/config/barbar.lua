-- Can't create/update/delete dictionary directly in lua.
local bufferline = {
	animation = true,
  auto_hide = false,
	icons = 'both',
  icon_custom_colors = false,
  icon_separator_active = '|',
  icon_separator_inactive = '|',
  closable = false,
	clickable = false,
	letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
	semantic_letters = true,
}

vim.g.bufferline = bufferline
