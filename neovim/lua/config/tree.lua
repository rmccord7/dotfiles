vim.g.nvim_tree_ignore = { '.git', 'out', 'dist' }
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 0
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1
}

vim.g.nvim_tree_icons = {
	default = '',
	git= {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★"
	},
	folder = {
		default = "",
		open = ""
	}
}
