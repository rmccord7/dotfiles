local ok, telescope = pcall(require, 'telescope')

if not ok then
    return
end

local ts = {}

local global = require('global')

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local themes = require('telescope.themes')

local util = require('config.telescope.util')

-- Default picker options.
local default_picker_opts = {
    grep_string = {
        prompt_title = 'word under cursor',
    },

    live_grep = {
        path_display = { 'smart' },
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
        follow = true,
        hidden = false,
    },

    oldfiles = {
        path_display = { 'smart' },
        only_cwd = true,
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
            n = {},
            i = {},
        },
        color_devicons = true,
        prompt_prefix = '🔍 ',
        scroll_strategy = 'cycle',
        sorting_strategy = 'ascending',
        layout_strategy = 'flex',
        file_ignore_patterns = util.ignored_files,
        layout_config = {
            prompt_position = 'top',
            horizontal = {
                mirror = true,
                preview_cutoff = 100,
                preview_width = 0.5,
            },
            vertical = {
                mirror = true,
                preview_cutoff = 0.4,
            },
            flex = {
                flip_columns = 110,
            },
            height = 0.94,
            width = 0.86,
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
require('telescope').load_extension('vim_p4_files')
require('telescope').load_extension('notify')

-- Telescope mappings
util.builtin('<leader>ff', 'find_files', 'Find Files')
util.builtin('<leader>ow', 'oldfiles', 'List Old Files')
util.builtin('<leader>fw', 'grep_string', 'Grep String Under Cursor')
util.builtin('<leader>gw', 'live_grep', 'Grep String')
util.builtin('<leader>/', 'current_buffer_fuzzy_find', 'Fuzzy Find Current Buffer')
util.builtin('<leader>hp', 'help_tags', 'Plugin Help')
util.builtin('<leader>hm', 'man_pages', 'Find Manual')
util.builtin('<leader>jb', 'builtin', 'List Telescope Builtins')
util.builtin('<leader>tp', 'resume', 'Telecope Resume')
util.builtin('<leader>m', 'keymaps', 'List Keymaps')
util.builtin('<leader>ch', 'command_history', 'List Command History')

util.builtin('<leader>lr', 'lsp_references', 'List LSP References')
util.builtin('<leader>lc', 'lsp_document_symbols', 'List LSP Document Symbols')
util.builtin('<leader>ps', 'lsp_dynamic_workspace_symbols', 'List LSP Dynamic Workspace Symbols')
util.builtin('<leader>li', 'lsp_incoming_calls', 'List LSP Incoming Calls')
util.builtin('<leader>lo', 'lsp_outgoing_calls', 'List LSP Outgoing Calls')
util.builtin('gd', 'lsp_definitions', 'List LSP Definitions')
util.builtin('gD', 'lsp_implementations', 'List LSP Implementations')

nmap('<leader>fb', ':Telescope file_browser<CR>', 'File Browser')
nmap('<leader>pj', ':Telescope projects<CR>', 'List Projects')
nmap('<leader>nh', ':Telescope notify<CR>', 'List Notifications')
nmap('<leader>te', ':Telescope env<CR>', 'List Environment Variables')

-- Find_old_files, but all workspaces
util.custom('<leader>of', 'oldfiles', 'find_old_files', {
    only_cwd = false,
})

-- Find_files, but don't use ignored patterns
util.custom('<leader>fa', 'find_files', 'find_files_all', {
    file_ignore_patterns = {},
    no_ignore = true,
    hidden = true,
})

-- Find in dotfiles
util.custom('<leader>fd', 'find_files', 'find_dotfiles', {
    cwd = '~/dotfiles',
    prompt_title = 'files in dotfiles',
    file_ignore_patterns = {
        '%.ttf', -- Fonts
        'dotbot/*', -- Ignore dotbot in dotfiles
    },
    hidden = true,
})

-- Find in neovim config
util.custom('<leader>fn', 'find_files', 'find_neovim', {
    cwd = '~/dotfiles/neovim',
    prompt_title = 'files in neovim config',
})

-- Find in neovim plugins
util.custom('<leader>fp', 'find_files', 'find_plugins', {
    cwd =  vim.fn.stdpath('data') .. '/lazy',
    prompt_title = 'files in neovim plugins',
})

-- Grep inside of vim help docs
util.custom('<leader>vh', 'live_grep', 'grep_vim_help', {
    cwd = os.getenv('VIMRUNTIME') .. '/doc',
    prompt_title = 'Grep in vim help docs',
})

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

return ts
