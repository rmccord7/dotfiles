local M = {
  select = {
    enable = true,
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["aC"] = "@comment.outer",
      ["iC"] = "@comment.inner",
      ["ac"] = "@conditional.outer",
      ["ic"] = "@conditional.inner",
      ["ae"] = "@block.outer",
      ["ie"] = "@block.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["is"] = "@statement.inner",
      ["as"] = "@statement.outer",
      ["ad"] = "@comment.outer",
      ["am"] = "@call.outer",
      ["im"] = "@call.inner",
    },
    selection_modes = {
      ["@function.outer"] = "V",
      ["@function.inner"] = "V",
    },
  },
  swap = {
    enable = true,
    -- swap_next = {
    --     ['<leader>a'] = '@parameter.inner',
    -- },
    -- swap_previous = {
    --     ['<leader>A'] = '@parameter.inner',
    -- },
  },
  move = {
    enable = true,
  },
}

vim.keymap.set({"n"}, "]m", [[:TSTextobjectGotoNextStart @function.outer<CR>zz]], { desc = "Go to next function start" })
vim.keymap.set({"n"}, "]M", [[:TSTextobjectGotoNextEnd @function.outer<CR>zz]], { desc = "Go to next function end" })
vim.keymap.set({"n"}, "[m", [[:TSTextobjectGotoPreviousStart @function.outer<CR>zz]], { desc = "Go to previous function start" })
vim.keymap.set({"n"}, "[M", [[:TSTextobjectGotoPreviousEnd @function.outer<CR>zz]], { desc = "Go to previous function end" })

return M
