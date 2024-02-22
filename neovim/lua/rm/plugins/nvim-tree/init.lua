local config = function()

    local ok, plugin = pcall(require, 'nvim-tree')

    if not ok then
        return
    end

    vim.g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1,
    }

    vim.g.nvim_tree_icons = {
        default = '',
        git = {
            unstaged = '✗',
            staged = '✓',
            unmerged = '',
            renamed = '➜',
            untracked = '?',
        },
        folder = {
            default = '',
            open = '',
        },
    }

    plugin.setup({
        -- Main options
        sync_root_with_cwd = true,
        respect_buf_cwd = true,

        -- View options
        view = {
            centralize_selection = true,
            width = {},
            float = {
                enable = true,
            },
        },

        renderer = {
            group_empty = true, -- Compact folders that contain a single folder
            full_name = true, -- Display nodes whose name is wider than window (floating)
            special_files = {
                '.p4config',
                'stylua.toml',
                '.stylua.toml',
                'cargo.toml',
                'Makefile',
                'README.md',
                'readme.md',
            },
        },

        -- File options
        update_focused_file = {
            enable = true,
            update_root = true,
        },

        -- Filtered files/dirs
        filters = {
            custom = {
                '.git',
            },
        },
    })

    nmap('<leader>tt', [[:NvimTreeToggle<CR>]], 'Nvim tree toggle')
    nmap('<leader>tf', [[:NvimTreeFindFile<CR>]], 'Nvim tree find file')
end

local M = {
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
        },
        config = config,
    },
}

return M
