local _treesitter, _ = pcall(require, "nvim-treesitter")

if not _treesitter then
    return
end

require'nvim-treesitter.install'.compilers = { "clang" }
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "python", "lua", "yaml", "json", "bash", "rust" },
  sync_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 75 * 1024 -- 75 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
          return true
      end
    end,
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "CR",
      scope_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
  indent = {
    enable = false
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = false,
      keymaps = {
        goto_definition_lsp_fallback = "gd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "]d",
        goto_previous_usage = "[d",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aC'] = '@comment.outer',
        ['iC'] = '@comment.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['ae'] = '@block.outer',
        ['ie'] = '@block.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['is'] = '@statement.inner',
        ['as'] = '@statement.outer',
        ['ad'] = '@comment.outer',
        ['am'] = '@call.outer',
        ['im'] = '@call.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    keybindings = {
       toggle_query_editor = 'o',
       toggle_hl_groups = 'i',
       toggle_injected_languages = 't',
       toggle_anonymous_nodes = 'a',
       toggle_language_display = 'I',
       focus_language = 'f',
       unfocus_language = 'F',
       update = 'R',
       goto_node = '<cr>',
       show_help = '?',
     },   persist_queries = false, -- Whether the query persists across vim sessions
  }
}

require'treesitter-context'.setup{
  enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
    -- For all filetypes
    -- Note that setting an entry here replaces all other patterns for this entry.
    -- By setting the 'default' entry below, you can control which nodes you want to
    -- appear in the context window.
    default = {
      'class',
      'function',
      'method',
      'for',
      'while',
      'if',
      'switch',
      'case',
    },
    -- Patterns for specific filetypes
    -- If a pattern is missing, *open a PR* so everyone can benefit.
    tex = {
      'chapter',
      'section',
      'subsection',
      'subsubsection',
    },
    rust = {
      'impl_item',
      'struct',
      'enum',
    },
    scala = {
      'object_definition',
    },
    vhdl = {
      'process_statement',
      'architecture_body',
      'entity_declaration',
    },
    markdown = {
      'section',
    },
    elixir = {
      'anonymous_function',
      'arguments',
      'block',
      'do_block',
      'list',
      'map',
      'tuple',
      'quoted_content',
    },
    json = {
      'pair',
    },
    yaml = {
      'block_mapping_pair',
    },
  },
  exact_patterns = {
    -- Example for a specific filetype with Lua patterns
    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
    -- exactly match "impl_item" only)
    -- rust = true,
  },

-- [!] The options below are exposed but shouldn't require your attention,
--     you can safely ignore them.

zindex = 20, -- The Z-index of the context window
mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
-- Separator between context and content. Should be a single character string, like '-'.
-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
separator = nil,
}
