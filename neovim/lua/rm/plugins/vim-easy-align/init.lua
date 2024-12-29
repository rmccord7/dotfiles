return {
  'junegunn/vim-easy-align',
  init = function()
    -- Map vim-easy-align to ga
    vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)', { desc = 'Easy align' })

    -- Alignment for c-style variable declarations
    -- Cannot add/update/store keys from a dictionary without a WAR
    local t = {}

    --C style variables
    t.d = {
      pattern = [[ \**\(\S\+\s*[;=]\)\@=]],
      left_margin = 0,
      right_margin = 0,
    }

    t.p = {
      pattern = ' ',
      left_margin = 0,
      right_margin = 1,
      stick_to_left = 0,
      align = 'll',
      filter = 'g/@param/',
    }

    vim.g.easy_align_delimiters = t
  end,
}
