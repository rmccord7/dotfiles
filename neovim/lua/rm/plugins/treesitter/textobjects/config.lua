return {
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ['af'] = '@function.outer',
      ['if'] = '@function.inner',
      ['aC'] = '@comment.outer',
      ['iC'] = '@comment.inner',
      ['ac'] = '@conditional.outer',
      ['ic'] = '@conditional.inner',
      ['ae'] = '@block.outer',
      ['ie'] = '@block.inner',
      ['al'] = '@loop.outer',
      ['il'] = '@loop.inner',
      ['is'] = '@statement.inner',
      ['as'] = '@statement.outer',
      ['ad'] = '@comment.outer',
      ['am'] = '@call.outer',
      ['im'] = '@call.inner',
      -- You can optionally set descriptions to the mappings (used in the desc parameter of
      -- nvim_buf_set_keymap) which plugins like which-key display
      -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      -- You can also use captures from other query groups like `locals.scm`
      -- ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
    },

    -- You can choose the select mode (default is charwise 'v')
    --
    -- Can also be a function which gets passed a table with the keys
    -- * query_string: eg '@function.inner'
    -- * method: eg 'v' or 'o'
    -- and should return the mode ('v', 'V', or '<c-v>') or a table
    -- mapping query_strings to modes.
    selection_modes = {
      ['@function.outer'] = 'V',
      ['@function.inner'] = 'V',
    },

    -- If you set this to `true` (default is `false`) then any textobject is
    -- extended to include preceding or succeeding whitespace. Succeeding
    -- whitespace has priority in order to act similarly to eg the built-in
    -- `ap`.
    --
    -- Can also be a function which gets passed a table with the keys
    -- * query_string: eg '@function.inner'
    -- * selection_mode: eg 'v'
    -- and should return true or false
    include_surrounding_whitespace = true,
  },
  swap = {
    enable = true,
    swap_next = {
      ['<leader>a'] = '@parameter.inner',
    },
    swap_previous = {
      ['<leader>A'] = '@parameter.inner',
    },
  },
  move = {
    enable = true,
  },
}
