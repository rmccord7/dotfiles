local menu_hl = {
  Class = "ItemMenuClass",
  Struct = "ItemMenuStruct",
  Module = "ItemMenuStruct",
  Snippet = "ItemMenuSnippet",
  Method = "ItemMenuMethod",
  Function = "ItemMenuFunction",
  Field = "ItemMenuField",
  Enum = "ItemMenuEnum",
  Variable = "ItemMenuVariable",
  Property = "ItemMenuProperty",
  Keyword = "ItemMenuProperty",
  Value = "ItemMenuValue",
  Text = "ItemMenuText",
  String = "ItemMenuText",
  Unknown = "ItemMenuUnknown",
}

local kind_hl = {
  Class = "ItemKindClass",
  Struct = "ItemKindStruct",
  Module = "ItemKindStruct",
  Snippet = "ItemKindSnippet",
  Method = "ItemKindMethod",
  Function = "ItemKindFunction",
  Field = "ItemKindField",
  Enum = "ItemKindEnum",
  Variable = "ItemKindVariable",
  Property = "ItemKindProperty",
  Keyword = "ItemKindProperty",
  Value = "ItemKindValue",
  Text = "ItemKindText",
  String = "ItemKindText",
  Unknown = "ItemKindUnknown",
}

local kind_names = {
  spell = "en",
  codeium = "code",
}

local kind_symbol = {
  cody = "󰚩",
  codeium = "󰚩",
  spell = "󰊀",
}

local M = {
  {
    "saghen/blink.cmp",
    dev = true,
    lazy = false,
    version = "v0.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",

        ["<CR>"] = { "select_and_accept", "fallback" },

        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<C-l>"] = {
          function(cmp)
            cmp.show({ providers = { "luasnip" } })
          end,
        },
      },

      fuzzy = {
        use_typo_resistance = true,
        use_frecency = true,
        use_proximity = true,
        sorts = { "score", "sort_text" },
      },

      sources = {
        default = { "lsp", "path", "luasnip", "buffer", "lazydev" },

        providers = {
          lsp = {
            transform_items = function(_, items)
              -- demote snippets
              for _, item in ipairs(items) do
                if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                  item.score_offset = item.score_offset - 3
                end
              end

              -- filter out text items, since we have the buffer source
              return vim.tbl_filter(function(item)
                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
              end, items)
            end,
          },
          -- Dont show LuaLS require statements when lazydev has items
          lazydev = { name = "LazyDev", fallbacks = { "lsp" }, module = "lazydev.integrations.blink" },
          luasnip = { score_offset = -99 },
        },
      },

      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },

      completion = {
        keyword = {
          range = "prefix",
          regex = "[-_]\\|\\k",
          exclude_from_prefix_regex = "[\\-]",
        },

        trigger = {
          show_in_snippet = true,
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_blocked_trigger_characters = { " ", "\n", "\t" },
          show_on_accept_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = { "'", '"', "(" },
        },

        list = {
          max_items = 200,
          selection = "preselect",
          cycle = {
            from_bottom = true,
            from_top = true,
          },
        },

        accept = {
          create_undo_point = true,
          auto_brackets = {
            enabled = true,
            default_brackets = { "(", ")" },
            override_brackets_for_filetypes = {},
            force_allow_filetypes = {},
            blocked_filetypes = {},
            kind_resolution = {
              enabled = true,
              blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
            },
            semantic_token_resolution = {
              enabled = true,
              blocked_filetypes = {},
              timeout_ms = 400,
            },
          },
        },

        menu = {
          enabled = true,
          min_width = 15,
          max_height = 10,
          border = "single",
          winblend = 10,
          -- winhighlight = "Normal:CmpComplitionMenu,FloatBorder:CmpComplitionMenu,CursorLine:CmpSelectedItem,Search:None",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          scrolloff = 2,
          scrollbar = true,
          direction_priority = { "s", "n" },
          order = { n = "bottom_up", s = "top_down" },
          auto_show = true,
          draw = {
            align_to_component = "kind_icon", -- or 'none' to disable
            padding = { 0, 1 },
            gap = 1,
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "kind", "source_name", gap = 1 },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local lspkind = require("lspkind")
                  -- return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
                  return " "
                    .. (lspkind.presets.default[ctx.kind] or kind_symbol[ctx.kind] or kind_symbol[string.lower(
                      ctx.source_name
                    )] or "")
                    .. ctx.icon_gap
                    .. " "
                end,
                highlight = function(ctx)
                  -- return (
                  --     require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                  --     or "BlinkCmpKind"
                  -- ) .. ctx.kind
                  return kind_hl[ctx.kind] or "CmpItemKindUnknown"
                end,
              },

              kind = {
                ellipsis = true,
                width = { fill = true },
                text = function(ctx)
                  if ctx.kind == "Unknown" then
                    return kind_names[string.lower(ctx.source_name)] or ctx.kind
                  end
                  return ctx.kind
                end,
                highlight = function(ctx)
                  -- return (
                  --     require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                  --     or "BlinkCmpKind"
                  -- ) .. ctx.kind
                  return menu_hl[ctx.kind] or "CmpItemMenuUnknown"
                end,
              },

              label = {
                ellipsis = true,
                width = { fill = true, max = 60 },
                text = function(ctx)
                  return ctx.label .. ctx.label_detail
                end,
                highlight = function(ctx)
                  -- label and label details
                  local highlights = {
                    {
                      0,
                      #ctx.label,
                      group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
                    },
                  }
                  if ctx.label_detail then
                    table.insert(highlights, {
                      #ctx.label,
                      #ctx.label + #ctx.label_detail,
                      group = "BlinkCmpLabelDetail",
                    })
                  end

                  -- characters matched on the label by the fuzzy matcher
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end

                  return highlights
                end,
              },

              label_description = {
                width = { max = 20, min = 10 },
                text = function(ctx)
                  return ctx.label_description
                end,
                highlight = "BlinkCmpLabelDescription",
              },

              source_name = {
                width = { max = 20, min = 10 },
                text = function(ctx)
                  return string.lower(ctx.source_name)
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          update_delay_ms = 50,
          treesitter_highlighting = true,
          window = {
            min_width = 10,
            max_width = 60,
            max_height = 20,
            desired_min_width = 50,
            desired_min_height = 10,
            border = "padded",
            winblend = 0,
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
            scrollbar = true,
            direction_priority = {
              menu_north = { "e", "w", "n", "s" },
              menu_south = { "e", "w", "s", "n" },
            },
          },
        },

        ghost_text = {
          enabled = true,
        },
      },

      signature = {
        enabled = true,
        trigger = {
          blocked_trigger_characters = {},
          blocked_retrigger_characters = {},
          show_on_insert_on_trigger_character = true,
        },
        window = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = "padded",
          winblend = 0,
          winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
          scrollbar = false,
          direction_priority = { "n", "s" },
          treesitter_highlighting = true,
        },
      },
    },

    opts_extend = { "sources.default" },

    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
      { "onsails/lspkind.nvim" },
    },
  },
}

return M
