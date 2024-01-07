local ok, ls = pcall(require, 'luasnip')
if not ok then
    return
end

ls.config.set_config({
    -- Allows reentering old snippets
    history = true,

    -- Update snippets dynamically while typing
    updateevents = 'TextChanged,TextChangedI',

    -- Delete snippets from history when appropriate
    delete_check_events = 'InsertLeave',

    -- Don't need autosnippets for now
    enabled_autosnippets = false,

    -- Ask treesitter for filetype for sub-languages
    ft_func = require('luasnip.extras.filetype_functions').from_pos_or_filetype,
})

-- Set up actual snippets, TODO: lazy loading
require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/dotfiles/neovim/lua/plugins/luasnip/vscode' } })
require('luasnip.loaders.from_lua').load()
