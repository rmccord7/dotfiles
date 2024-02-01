local config = function()

    local ok, _ = pcall(require, 'ss1pwn')

    if not ok then
        return
    end

    nmap('<F9>', [[:lua require('ss1pwn.comment').next_bad_comment()<CR>]], 'Next bad ss1 comment')
    vmap('<F10>', [[:lua require('ss1pwn.comment').format_comment()<CR>]], 'Format bad ss1 comment')
    vmap('<F11>', [[:lua require('ss1pwn.comment').format_all_comments()<CR>]], 'Format all bad ss1 comments')

end

local M = {
    {
        'rmccord7/ss1pwn',
        config = config,
        ft = 'c',
    },
}

return M
