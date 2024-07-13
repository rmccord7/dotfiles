-- Map commands.
_G.map = function(modes, lhs, rhs, label, opts)
    local uses_leader = lhs:match('<leader>.*')

    -- Add leader key bindings to which-key.
    if uses_leader then
        local ok, wk = pcall(require, 'which-key')
        if ok then

            -- make an iterable table of all the modes for this keymap
            modes = type(modes) == 'string' and { modes } or modes

            for _, mode in ipairs(modes) do
                -- if we don't supply a label, remind me that i need to add one and avoid an error
                if not label then
                    if type(rhs) == 'string' then
                        label = rhs:gsub('<cmd>lua ', ''):gsub('<cr>', '')
                    else
                        label = 'needs label'
                    end
                end

                wk.add({
                    lhs,
                    rhs,
                    desc = label,
                    mode = mode,
                    silent = true,
                    noremap = true,
                    buffer = opts and opts.buffer or nil,
                    -- prefix = lhs:sub(1, -2), -- extract all but the last keystroke of the mapping
                })
            end
            return
        end
    end

    -- If we didn't have a <leader> mapping or which key is unavailable, default
    -- to built-in lua function vim.keymap.set()

    -- Extend the default options with user's overrides
    local default_opts = { noremap = true, silent = true }
    opts = opts and vim.tbl_extend('keep', opts, default_opts) or default_opts

    -- Set the keymapping.
    vim.keymap.set(modes, lhs, rhs, opts)
end

_G.nmap = function(lhs, rhs, label, opts)
    map('n', lhs, rhs, label, opts)
end

_G.imap = function(lhs, rhs, label, opts)
    map('i', lhs, rhs, label, opts)
end

_G.vmap = function(lhs, rhs, label, opts)
    map('v', lhs, rhs, label, opts)
end

_G.xmap = function(lhs, rhs, label, opts)
    map('x', lhs, rhs, label, opts)
end

_G.cmap = function(lhs, rhs, label, opts)
    map('c', lhs, rhs, label, opts)
end

_G.tmap = function(lhs, rhs, label, opts)
    map('t', lhs, rhs, label, opts)
end

_G.omap = function(lhs, rhs, label, opts)
    map('o', lhs, rhs, label, opts)
end

_G.smap = function(lhs, rhs, label, opts)
    map('s', lhs, rhs, label, opts)
end

_G.icmap = function(lhs, rhs, label, opts)
    map('!', lhs, rhs, label, opts)
end

-- Global table with all my user-created aucmds
_G.Augroups = {}

-- Helper for creating a new augroup and autocmds along with a toggler
_G.create_augroup = function(group, aucmds)
    -- Create new augroup
    vim.api.nvim_create_augroup(group, {
        clear = true,
    })

    -- Create this augroup's entry in the global table if it doesn't exist
    if not _G.Augroups[group] then
        _G.Augroups[group] = {
            enabled = true,
            aucmds = aucmds,
        }
    end

    -- Loop through the table of aucmds and create each one
    for _, aucmd in ipairs(aucmds) do
        -- Add the current augroup name to the autocmd config table
        local aucmd_config = vim.tbl_extend('keep', { group = group }, aucmd)

        -- Remove events key from config to pass to autocmd API function
        aucmd_config.events = nil
        vim.api.nvim_create_autocmd(aucmd.events, aucmd_config)
    end
end

--- Helper function to toggle an augroup on/off
--- @param group string name of autogroup to toggle
--- @param show_notify boolean if true don't show notification (default false)
_G.toggle_augroup = function(group, show_notify)
    if _G.Augroups[group].enabled then
        _G.Augroups[group].enabled = false
        vim.api.nvim_del_augroup_by_name(group)
        if not show_notify then
            vim.notify('Disabled ' .. group)
        end
    else
        _G.Augroups[group].enabled = true
        create_augroup(group, _G.Augroups[group].aucmds)
        if not show_notify then
            vim.notify('Disabled ' .. group)
        end
        vim.notify('Enabled ' .. group)
    end
end

-- quickly print a lua table to :messages
_G.dump = function(obj, use_notify)
    if use_notify then
        vim.notify(obj, vim.log.levels.DEBUG, { timeout = false })
    else
        print(vim.inspect(obj))
    end
    return obj
end

return M
