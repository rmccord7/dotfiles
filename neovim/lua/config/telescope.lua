local ok, telescope = pcall(require, "telescope")

if not ok then
    return
end

local ts = {}

local map = require 'utils'.map
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
    file_ignore_patterns = ignored_files,
  },

  git_commits = {
    selection_strategy = 'row',
    prompt_title = 'git log',
  },

  buffers = {
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
    find_command = { 'rg', '--files', '-L' },
    follow = true,
    hidden = false,
    no_ignore = true,
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
        ['<C-x>'] = false,
        ['<C-s>'] = actions.select_horizontal,
        ['<C-q>'] = actions.send_to_qflist,
        ['<M-q>'] = actions.send_selected_to_qflist,
      },
      i = {
        ['<C-x>'] = false,
        ['<C-s>'] = actions.select_horizontal,
        ['<C-q>'] = actions.send_to_qflist,
        ['<M-q>'] = actions.send_selected_to_qflist,
      },
    },
    color_devicons = true,
    prompt_prefix = '???? ',
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
    },
    file_browser = {
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}

-- function for generating keymap for each picker
local builtin = function(mapping, picker, is_custom)
  local module = is_custom and 'config.telescope' or 'telescope.builtin'
  local rhs = string.format([[<cmd>lua require'%s'.%s()<CR>]], module, picker)
  map('n', mapping, rhs, {silent = true})
end

local custom = function(mapping, picker_name, builtin_name, opts)
  opts = opts or {}
  ts[picker_name] = function()
    require('telescope.builtin')[builtin_name](opts)
  end
  local rhs = string.format([[<cmd>lua require'config.telescope'.%s()<CR>]], picker_name)
  map('n', mapping, rhs, {silent = true})
end

-- my telescope builtins mappings
builtin('<leader>ff', 'find_files')
builtin('<leader>of', 'oldfiles')
builtin('<leader>fw', 'grep_string')
builtin('<leader>gw', 'live_grep') -- grep word
builtin('<leader>gib', 'current_buffer_fuzzy_find') -- grep in buffer
builtin('<leader>gl', 'git_commits') -- git log
builtin('<leader>gb', 'git_branches')
builtin('<leader>gh', 'help_tags')
builtin('<leader>gm', 'man_pages')
builtin('<leader>bl', 'buffers')
builtin('<leader>ts', 'builtin')
builtin('<leader>rp', 'reloader')
builtin('<leader>tp', 'resume') -- telescope previous
builtin('<leader>ps', 'lsp_dynamic_workspace_symbols') -- project symbols
builtin('<leader>ca', 'lsp_code_actions')

-- find_files, but don't use ignored patterns
custom('<leader>fa', 'find_files_all', 'find_files', {
  file_ignore_patterns = {},
  no_ignore = true,
  hidden = true,
})

-- find in dotfiles
custom('<leader>fd', 'find_dotfiles', 'find_files', {
  cwd = '~/dotfiles',
  prompt_title = 'files in dotfiles',
  file_ignore_patterns = {
    'dotbot/*', -- Ignore dotbot in dotfiles
  },
})

-- find in neovim config
custom('<leader>fn', 'find_neovim', 'find_files', {
  cwd = '~/dotfiles/neovim',
  prompt_title = 'files in neovim config',
})

-- grep inside of dotfiles
custom('<leader>gid', 'grep_in_dotfiles', 'live_grep', {
  cwd = '~/dotfiles',
  prompt_title = 'grep in dotfiles',
})

-- grep inside of neovim config
custom('<leader>gin', 'grep_in_neovim', 'live_grep', {
  cwd = '~/.config/nvim',
  prompt_title = 'grep in neovim config',
})

-- grep inside of vim help docs
custom('<leader>vh', 'grep_vim_help', 'live_grep', {
  cwd = os.getenv 'VIMRUNTIME' .. '/doc',
  prompt_title = 'Grep in vim help docs',
})

-- jump to a buffer
custom(
  '<leader>jb',
  'jump_to_buffer',
  'buffers',
  vim.tbl_deep_extend('force', themes.get_dropdown(), {
    preview = false,
    prompt_title = 'Jump to buffer',
  })
)

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
map('n', '<leader>pc', [[<cmd>lua require'config.telescope'.packer_commands()<CR>]], {silent = true})

--Load native lua fzy since it is faster than the defaults.
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('neoclip')
require('telescope').load_extension('harpoon')
require('telescope').load_extension('projects')
require('telescope').load_extension('file_browser')

return ts
