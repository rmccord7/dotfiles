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

nmap("]m", [[:TSTextobjectGotoNextStart @function.outer<CR>zz]], "Go to next function start")
nmap("]M", [[:TSTextobjectGotoNextEnd @function.outer<CR>zz]], "Go to next function end")
nmap("[m", [[:TSTextobjectGotoPreviousStart @function.outer<CR>zz]], "Go to previous function start")
nmap("[M", [[:TSTextobjectGotoPreviousEnd @function.outer<CR>zz]], "Go to previous function end")

return M
