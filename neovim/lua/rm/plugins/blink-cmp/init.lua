local source_priority = {
  snippets = 4,
  lsp = 3,
  path = 2,
  buffer = 1,
}

return {
  'saghen/blink.cmp',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
    },
    {
      'rafamadriz/friendly-snippets',
    },
  },
  lazy = false,
  -- version = 'v0.*',
  build = 'cargo build --release',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
    },

    fuzzy = {
      sorts = {
        'exact',
        'score',
        'sort_text',
      },
    },

    keymap = {
      preset = 'enter',

      ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },

      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },

      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },

    cmdline = {
      keymap = {
        preset = 'super-tab',

        ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },

        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },

        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },
    },

    snippets = {
      preset = 'luasnip',
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },

      providers = {
        -- Dont show LuaLS require statements when lazydev has items
        lazydev = {
          name = 'LazyDev',
          fallbacks = { 'lsp' },
          module = 'lazydev.integrations.blink',
        },
      },
    },

    completion = {
      menu = {
        -- winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
        draw = {
          align_to = 'kind_icon',
          columns = {
            { 'label', gap = 1 },
            { 'kind_icon', gap = 1 },
            { 'kind', gap = 1 },
            { 'source_name' },
          },
          components = {

            kind = {
              ellipsis = true,
            },

            label = {
              text = require("colorful-menu").blink_components_text,
              highlight = require("colorful-menu").blink_components_highlight,
            },

            label_description = {
              width = { max = 20, min = 10 },
            },

            source_name = {
              width = { max = 20, min = 10 },
            },
          },
        },
      },

      documentation = {
        window = {
          -- winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
        },
      },

      ghost_text = {
        enabled = true,
      },
    },

    signature = {
      enabled = true,
    },
  },
}
