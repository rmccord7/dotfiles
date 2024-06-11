local config = function()
    local ok, telescope = pcall(require, 'telescope')

    if not ok then
        return
    end

    local actions = require('telescope.actions')

    local util = require('rm.plugins.telescope.util')

    -- Open all or selected files for add.
    local p4_add = require("p4.telescope").add

    -- Open all or selected files for edit.
    local p4_edit = require("p4.telescope").edit

    -- Revert all or selected files that are opened for add/edit.
    local p4_revert = require("p4.telescope").revert

    -- Get file information.
    local p4_fstat = require("p4.telescope").fstat

    local default_picker_opts = {
        live_grep = {
            path_display = { 'truncate' },
            file_ignore_patterns = util.ignored_files,
        },

        git_commits = {
            selection_strategy = 'row',
            prompt_title = 'git log',
        },

        buffers = {
            path_display = { 'smart' },
            show_all_buffers = true,
            attach_mappings = function(_, local_map)
                local_map('n', 'd', actions.delete_buffer)
                local_map('i', '<c-x>', actions.delete_buffer)
                return true
            end,
        },

        git_branches = {
            attach_mappings = function(_, local_map)
                local_map('i', '<c-o>', actions.git_checkout)
                local_map('n', '<c-o>', actions.git_checkout)
                return true
            end,
            selection_strategy = 'row',
        },

        find_files = {
            path_display = { 'smart' },
            find_command = { 'rg', '--files', '-L' },
        },

        oldfiles = {
            path_display = { 'smart' },
        },
    }

    telescope.setup({
        pickers = default_picker_opts,
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
            },
            mappings = {
                n = {
                    ['jk'] = actions.close,
                    ['kj'] = actions.close,
                    ["<c-a>"] = p4_add,
                    ["<c-e>"] = p4_edit,
                    ["<c-r>"] = p4_revert,
                    ["<c-g>"] = p4_fstat,
                    ['<C-t>'] = require("trouble.sources.telescope").open,
                },
                i = {
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,
                    ["<c-a>"] = p4_add,
                    ["<c-e>"] = p4_edit,
                    ["<c-r>"] = p4_revert,
                    ["<c-g>"] = p4_fstat,
                    ['<C-t>'] = require("trouble.sources.telescope").open,
                },
            },
            prompt_prefix = '🔍 ',
            sorting_strategy = 'ascending',
            layout_strategy = 'flex',
            file_ignore_patterns = util.ignored_files,
            layout_config = {
                prompt_position = 'top',
                horizontal = {
                    mirror = true,
                },
                vertical = {
                    mirror = true,
                },
                flex = {
                    flip_columns = 110,
                },
            },
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
                case_mode = 'smart_case',
            },
            file_browser = {
                theme = nil,
                hijack_netrw = false,
            },
        },
    })

    --Load native lua fzy since it is faster than the defaults.
    require('telescope').load_extension('fzy_native')
    require('telescope').load_extension('neoclip')
    require('telescope').load_extension('projects')
    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('env')
    require('telescope').load_extension('notify')
    require('telescope').load_extension('lazy')
    require('telescope').load_extension('p4')

    -- Telescope mappings
    util.builtin('<leader>sw', 'grep_string', 'Find Word Under Cursor')
    util.builtin('<leader>gw', 'live_grep', 'Grep String')
    util.builtin('<leader>/', 'current_buffer_fuzzy_find', 'Fuzzy Find Current Buffer')
    util.builtin('<leader>hv', 'help_tags', 'Plugin Help')
    util.builtin('<leader>hm', 'man_pages', 'Find Manual')
    util.builtin('<leader>jb', 'builtin', 'List Telescope Builtins')
    util.builtin('<leader>tr', 'resume', 'Telecope Resume')
    util.builtin('<leader>m', 'keymaps', 'List Keymaps')
    util.builtin('<leader>ch', 'command_history', 'List Command History')

    util.builtin('<leader>ff', 'find_files', 'Workspace Files')

    util.custom('<leader>fa', 'find_files', 'Workspace Files (All)', {
        no_ignore = true,
        hidden = true,
    })

    util.builtin('<leader>rw', 'oldfiles', 'Recent Files')

    util.custom('<leader>ra', 'oldfiles', 'Recent Files (All)', {
        no_ignore = true,
        hidden = true,
    })

    util.custom('<leader>fd', 'find_files', 'Search Dotfiles', {
        cwd = '~/dotfiles',
    })

    util.custom('<leader>fh', 'find_files', 'Search Home', {
        cwd = '~',
    })

    -- Grep inside of vim help docs
    util.custom('<leader>gv', 'live_grep', 'Grep Vim Help', {
        cwd = os.getenv('VIMRUNTIME') .. '/doc',
    })

    util.builtin('<leader>lr', 'lsp_references', 'List LSP References')
    util.builtin('<leader>lc', 'lsp_document_symbols', 'List LSP Document Symbols')
    util.builtin('<leader>ps', 'lsp_dynamic_workspace_symbols', 'List LSP Dynamic Workspace Symbols')
    util.builtin('<leader>li', 'lsp_incoming_calls', 'List LSP Incoming Calls')
    util.builtin('<leader>lo', 'lsp_outgoing_calls', 'List LSP Outgoing Calls')
    util.builtin('gd', 'lsp_definitions', 'List LSP Definitions')
    util.builtin('gD', 'lsp_implementations', 'List LSP Implementations')

    -- LSP current buffer diagnostics
    util.custom('<leader>ld', 'diagnostics', 'Buffer Diagnostics', {
        bufnr = 0,
    })

    -- LSP current error diagnostics
    util.custom('<leader>le', 'diagnostics', 'Buffer Errors', {
        bufnr = 0,
        severity = vim.diagnostic.severity.ERROR,
    })

    -- LSP current warning diagnostics
    util.custom('<leader>lw', 'diagnostics', 'Buffer Warnings', {
        bufnr = 0,
        severity = vim.diagnostic.severity.WARN,
    })

    -- LSP project diagnostics
    util.custom('<leader>lp', 'diagnostics', 'Project Diagnostics', {})

    nmap('<leader>fb', ':Telescope file_browser<CR>', 'File Browser')
    nmap('<leader>pj', ':Telescope projects<CR>', 'List Projects')
    nmap('<leader>nh', ':Telescope notify<CR>', 'List Notifications')
    nmap('<leader>te', ':Telescope env<CR>', 'List Environment Variables')
    nmap('<leader>tp', ':Telescope lazy<CR>', 'Plugin Browser')
end

local M = {

    {
        'nvim-telescope/telescope.nvim',
        config = config,
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'LinArcX/telescope-env.nvim',
            'tsakirist/telescope-lazy.nvim',
            'rmccord7/p4.nvim',
        },
    },
}

return M
