local config = function()
    local ok, plugin = pcall(require, 'neovim-project')

    if not ok then
        return
    end

    opts = {
        projects = { -- define project roots
            "~/projects/*",
            "~/.config/*",
            "~/perforce/ganges/rel/*",
            "~/perforce/ganges/dev/*",
        },
        -- Path to store history and sessions
        datapath = vim.fn.stdpath("data"), -- ~/.local/share/nvim/
        last_session_on_startup = false, -- Load the most recent session on startup if not in the project directory
        dashboard_mode = false, -- Dashboard mode prevent session autoload on startup
        -- Timeout in milliseconds before trigger FileType autocmd after session load
        -- to make sure lsp servers are attached to the current buffer.
        -- Set to 0 to disable triggering FileType autocmd
        filetype_autocmd_timeout = 200,

        -- Overwrite some of Session Manager options
        session_manager_opts = {
            autosave_ignore_dirs = {
                vim.fn.expand("~"), -- don't create a session for $HOME/
                "/tmp",
            },
            autosave_ignore_filetypes = {
                -- All buffers of these file types will be closed before the session is saved
                'ccc-ui',
                'gitcommit',
                'gitrebase',
                'qf',
                'toggleterm',
                'NvimTree',
                'help',
                'lazy',
            },
        },
    }

    plugin.setup(opts)

    nmap('<leader>pd', ':Telescope neovim-project discover<CR>', 'Discover Projects')
    nmap('<leader>pj', ':Telescope neovim-project history<CR>', 'List Projects')
end

local M = {
    {
        "coffebar/neovim-project",
        config = config,
        init = function()
            -- enable saving the state of plugins in the session
            vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            -- { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
            { "nvim-telescope/telescope.nvim"},
            { "Shatur/neovim-session-manager" },
        },
        lazy = false,
        priority = 100,
    },
}

return M
