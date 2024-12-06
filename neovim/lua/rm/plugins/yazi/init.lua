local config = function()
    local ok, _ = pcall(require, 'yazi')

    if not ok then
        return
    end
end

local M = {
    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        config = config,
        event = "VeryLazy",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>-",
                function()
                    require("yazi").yazi()
                end,
                desc = "Open the file manager",
            },
            {
                -- Open in the current working directory
                "<leader>cw",
                function()
                    require("yazi").yazi(nil, vim.fn.getcwd())
                end,
                desc = "Open the file manager in nvim's working directory" ,
            },
        },
        ---@type YaziConfig
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
              show_help = '<f1>',
            },
        },
    },
}

return M
