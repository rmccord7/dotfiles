local config = function()

    -- Map vim-easy-align to ga
    xmap('ga', '<Plug>(EasyAlign)', 'Easy align', {})
    nmap('ga', '<Plug>(EasyAlign)', 'Easy align', {})

    -- Alignment for c-style variable declarations
    -- NOTE: Cannot add/update/store keys from a dictionary without a workaroumd
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
end

local M = {
    {
        'junegunn/vim-easy-align',
        config = config,
    },
}

return M
