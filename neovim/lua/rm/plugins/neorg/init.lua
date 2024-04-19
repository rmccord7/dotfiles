local config = function()
    local ok, plugin = pcall(require, 'neorg')

    if not ok then
        return
    end

    plugin.setup {
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp"
                }
            },
            ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        work = "~/.local/docs/qualcomm",
                        home = "~/notes",
                    },
                },
            },
        },
    }
end

local M = {
    {
        "nvim-neorg/neorg",
        -- ft = 'norg',
        config = config,
        rocks = { "lua-utils.nvim", "nvim-nio", "nui.nvim", "plenary.nvim" },
    },

    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
}

return M
