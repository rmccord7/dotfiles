
return {
  'rmccord7/c-format-comment.nvim',
  dev = true,
  config = function(_, _)
    vim.keymap.set(
      { 'n', 'v' },
      '<leader>gq',
      [[:lua require("c-format-comment").format()<CR>]],
      { nowait = true, desc = "Format all C comments in the visual selection" }
    )
  end,
}
