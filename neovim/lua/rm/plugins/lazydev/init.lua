local config = function()
    local ok, plugin = pcall(require, 'lazydev')

    if not ok then
        return
    end

    opts = {
        -- runtime = vim.env.VIMRUNTIME --[[@as string]],
        -- library = {}, ---@type string[]
        -- ---@param client vim.lsp.Client
        -- enabled = function(client)
        --     if vim.g.lazydev_enabled ~= nil then
        --         return vim.g.lazydev_enabled
        --     end
        --     return client.root_dir and vim.uv.fs_stat(client.root_dir .. "/lua") and true or false
        -- end,
    }

    plugin.setup(opts)
end

local M = {
    {
        "folke/lazydev.nvim",
        config = config,
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- Library items can be absolute paths
                -- "~/projects/my-awesome-lib",
                -- Or relative, which means they will be resolved as a plugin
                -- "LazyVim",
                -- When relative, you can also provide a path to the library in the plugin dir
                "luvit-meta/library", -- see below
            },
        },

    },

    -- optional `vim.uv` typings
    {
        "Bilal2453/luvit-meta",
        lazy = true
    },

    { -- optional completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
}

return M
