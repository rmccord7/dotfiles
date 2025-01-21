
return {
  'rmccord7/c-format-comment.nvim',
  dev = true,
  config = function(_, _)
    vim.keymap.set(
      { 'v' },
      '<leader>gq',
      [[:lua require("c-format-comment").format_all()<CR>]],
      { nowait = true, desc = "Format all C comments in the visual selection" }
    )
  end,
}
