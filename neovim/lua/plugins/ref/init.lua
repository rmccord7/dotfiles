local M = {

    {
        'nanotee/nvim-lua-guide',
    },

    {
        'milisims/nvim-luaref',
    },

    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("neorg").setup {
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
        end,
      },
}

return M
