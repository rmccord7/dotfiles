local ok, telescope = pcall(require, "telescope")

if not ok then
    return
end

local ts = {}

local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local finders = require 'telescope.finders'
local themes = require 'telescope.themes'

-- Files to ignore with `file_ignore_patterns`
local ignored_files = {
  '.git/.*',
  'tags',
  '%.svg',
  '%.png',
  '%.jpeg',
  '%.jpg',
  '%.ico',
  '%.o',
  '^%.api',
  '%.a',
  '%.cmake',
  '%.lib',
  '%.so',
  '.cache/*',
  'SDK_BIN/*',
  'SRC/*',
  'SRC_ESL/*',
  'SRC_SODAQ/*',
  'out/',
  'out_single/',
}

-- Default picker options.
local default_picker_opts = {
  grep_string = {
    prompt_title = 'word under cursor',
  },

  live_grep = {
    path_display = {'smart'},
    file_ignore_patterns = ignored_files,
  },

  git_commits = {
    selection_strategy = 'row',
    prompt_title = 'git log',
  },

  buffers = {
    path_display = {'smart'},
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
    path_display = {'smart'},
    find_command = { 'rg', '--files', '-L' },
    follow = true,
    hidden = false,
  },

  oldfiles = {
    path_display = {'smart'},
    only_cwd = true,
  },
}

telescope.setup{
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
      },
      i = {
      },
    },
    color_devicons = true,
    prompt_prefix = '🔍 ',
    scroll_strategy = 'cycle',
    sorting_strategy = 'ascending',
    layout_strategy = 'flex',
    file_ignore_patterns = ignored_files,
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
}

--Load native lua fzy since it is faster than the defaults.
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('neoclip')
require('telescope').load_extension('projects')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('env')
require('telescope').load_extension('vim_p4_files')
require("telescope").load_extension("notify")

-- function for generating keymap for each picker
local builtin = function(lhs, picker, label)
  nmap(lhs, function()
    require('telescope.builtin')[picker]()
  end, label)
end

local custom = function(lhs, picker, label, opts)
  opts = opts or {}
  nmap(lhs, function()
    require('telescope.builtin')[picker](opts)
  end, label)
end

-- Telescope mappings
builtin('<leader>ff', 'find_files', 'Need label')
builtin('<leader>ow', 'oldfiles', 'Need label') -- old workspace files
builtin('<leader>fw', 'grep_string', 'Need label') -- find word
builtin('<leader>gw', 'live_grep', 'Need label') -- grep word
builtin('<leader>/', 'current_buffer_fuzzy_find', 'Need label') -- grep in buffer
builtin('<leader>gl', 'git_commits', 'Need label') -- git log
builtin('<leader>gb', 'git_branches', 'Need label')
builtin('<leader>gh', 'help_tags', 'Need label')
builtin('<leader>gm', 'man_pages', 'Need label')
builtin('<leader>bl', 'buffers', 'Need label') --Redundant with custom ?
builtin('<leader>ts', 'builtin', 'Need label')
builtin('<leader>rp', 'reloader', 'Need label')
builtin('<leader>tp', 'resume', 'Need label') -- telescope previous
builtin('<leader>ps', 'lsp_dynamic_workspace_symbols', 'Need label') -- project symbols

builtin('<leader>gc', 'git_commits', 'Need label')
builtin('<leader>gb', 'git_branches', 'Need label')
builtin('<leader>gs', 'git_status', 'Need label')
builtin('<leader>gp', 'git_bcommits', 'Need label')

builtin('<leader>lc', 'lsp_document_symbols', 'Need label')
builtin('<leader>lr', 'lsp_references', 'Need label')
builtin('gd', 'lsp_definitions', 'Need label')
builtin('gD', 'lsp_implementations', 'Need label')

nmap("<leader>fb", ':Telescope file_browser<CR>', 'File Browser')
nmap("<leader>pj", ':Telescope projects<CR>', 'List Projects')
nmap("<leader>tn", ':Telescope notify<CR>', 'List Notifications')

-- Find_old_files, but all workspaces
custom('<leader>of', 'oldfiles', 'find_old_files', {
  only_cwd = false,
})

-- Find_files, but don't use ignored patterns
custom('<leader>fa', 'find_files', 'find_files_all', {
  file_ignore_patterns = {},
  no_ignore = true,
  hidden = true,
})

-- Find in dotfiles
custom('<leader>fd', 'find_files', 'find_dotfiles', {
  cwd = '~/dotfiles',
  prompt_title = 'files in dotfiles',
  file_ignore_patterns = {
    'dotbot/*', -- Ignore dotbot in dotfiles
  },
  hidden = true,
})

-- Find in neovim config
custom('<leader>fn', 'find_files', 'find_neovim', {
  cwd = '~/dotfiles/neovim',
  prompt_title = 'files in neovim config',
})

-- Find in packer files
custom('<leader>fp', 'find_files', 'find_packer', {
  cwd = vim.fn.stdpath('data') .. '/site/pack/packer',
  prompt_title = 'files installed by packer',
})

-- grep inside of vim help docs
custom('<leader>vh', 'live_grep', 'grep_vim_help', {
  cwd = os.getenv 'VIMRUNTIME' .. '/doc',
  prompt_title = 'Grep in vim help docs',
})

-- jump to a buffer
custom(
  '<leader>jb',
  'buffers',
  'jump_to_buffer',
  vim.tbl_deep_extend('force', themes.get_dropdown(), {
    preview = false,
    prompt_title = 'Jump to buffer',
  })
)

-- LSP current buffer diagnostics
custom('<leader>ld', 'diagnostics', 'lsp_diagnostics_buffer', {
  bufnr = 0,
})

-- LSP current error diagnostics
custom('<leader>le', 'diagnostics', 'lsp_diagnostics_buffer_error', {
  bufnr = 0,
  severity = vim.diagnostic.severity.ERROR,
})

-- LSP current warning diagnostics
custom('<leader>lw', 'diagnostics', 'lsp_diagnostics_buffer_warn', {
  bufnr = 0,
  severity = vim.diagnostic.severity.WARN,
})

-- LSP project diagnostics
custom('<leader>lp', 'diagnostics', 'lsp_diagnostics_project', {
})

-- custom telescope picker to execute a packer.nvim command
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#guide-to-your-first-picker
ts.packer_commands = function(opts)
  local packer_commands = {
    'Clean',
    'Compile',
    'Install',
    'Load',
    'Profile',
    'Status',
    'Sync',
    'Update',
  }
  local dropdown = themes.get_dropdown()
  opts = opts and vim.tbl_deep_extend('keep', opts, dropdown) or dropdown

  pickers.new(opts, {
    prompt_title = 'Run a packer.nvim command',
    finder = finders.new_table(packer_commands),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local cmd = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if cmd then
          vim.cmd('Packer' .. cmd[1])
        end
      end)
      return true
    end,
    previewer = nil,
  }):find()
end
nmap('<leader>pc', [[<cmd>lua require'config.telescope'.packer_commands()<CR>]], 'Packer commands')

return ts
