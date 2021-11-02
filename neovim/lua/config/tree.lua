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
		untracked = "?"
	},
	folder = {
		default = "",
		open = ""
	}
}

require'nvim-tree'.setup {
  filters = {
    custom = {
      '.git',
      'out',
      'dist'
    },
  },
}
