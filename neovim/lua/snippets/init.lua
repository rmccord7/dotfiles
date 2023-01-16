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
require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/dotfiles/neovim/snippets' } })
require('luasnip.loaders.from_lua').load()

--- Reloads snippets for a given language, useful for editing snippets without restarting.
-- @param lang Language / filetype name.
-- @return Module containing the snippets.
local function reload_snips(lang)
    package.loaded['snippets.' .. lang] = nil
    return require('snippets.' .. lang)
end

ls.snippets = {
    all = reload_snips('all'),
    c = reload_snips('c'),
    lua = reload_snips('lua'),
    python = reload_snips('python'),
}
