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
  version = 'v0.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
    },

    keymap = {
      preset = 'default',

      -- ["<CR>"] = { "select_and_accept", "fallback" },
      --
      -- ["<C-k>"] = { "select_prev", "fallback" },
      -- ["<C-j>"] = { "select_next", "fallback" },

      -- ["<Tab>"] = {
      --   function(cmp)
      --     if cmp.snippet_active() then
      --       return cmp.accept()
      --     else
      --       return cmp.select_and_accept()
      --     end
      --   end,
      --   "snippet_forward",
      --   "fallback",
      -- },
      -- ["<S-Tab>"] = { "snippet_backward", "fallback" },

      -- ["<C-l>"] = {
      --   function(cmp)
      --     cmp.show({ providers = { "luasnip" } })
      --   end,
      -- },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'luasnip', 'buffer', 'lazydev' },

      providers = {
        -- Dont show LuaLS require statements when lazydev has items
        lazydev = {
          name = 'LazyDev',
          fallbacks = { 'lsp' },
          module = 'lazydev.integrations.blink',
        },
        -- luasnip = {
        --   score_offset = -99
        -- },
      },
    },

    completion = {
      menu = {
        -- winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
        draw = {
          align_to_component = 'kind_icon',
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'kind', 'source_name', gap = 1 },
          },
          components = {

            kind = {
              ellipsis = true,
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
        auto_show = true,
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
