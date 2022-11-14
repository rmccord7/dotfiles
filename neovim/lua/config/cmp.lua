local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, ls = pcall(require, "luasnip")
local lspkind_ok, lspkind = pcall(require, "lspkind")

if not (cmp_ok and luasnip_ok and lspkind_ok) then
    return
end

local types = require('cmp.types')

-- Use our own symbols for lsp
local symbol_map = {
  Text = '',
  Method = 'Ƒ',
  Function = 'ƒ',
  Constructor = '',
  Variable = '',
  Class = '',
  Interface = 'ﰮ',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '了',
  Keyword = '',
  Snippet = '﬌',
  Color = '',
  File = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Kind comparator function
local function kind_cmp(entry1, entry2)
    local kind1 = entry1:get_kind()
    kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
    kind1 = kind1 == types.lsp.CompletionItemKind.Variable and 1 or kind1
    local kind2 = entry2:get_kind()
    kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
    kind2 = kind2 == types.lsp.CompletionItemKind.Variable and 1 or kind2
    if kind1 ~= kind2 then
        if kind1 == types.lsp.CompletionItemKind.Snippet then
            return true
        end
        if kind2 == types.lsp.CompletionItemKind.Snippet then
            return false
        end
        local diff = kind1 - kind2
        if diff < 0 then
            return true
        elseif diff > 0 then
            return false
        end
    end
end

cmp.setup {
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end
  },

  -- You must set mapping if you want.
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif ls.expand_or_jumpable() then
        ls.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end,
  },

  -- You should specify your *installed* sources.
  sources = {
    { name = 'luasnip' },
    {
      name = 'nvim_lsp',
      max_item_count = 75,
    },
    { name = 'nvim_lsp_document_symbol' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'path' },
  },

  formatting = {
    format = lspkind.cmp_format(
      {
        symbol_map = symbol_map,
        mode = 'symbol_text',
        menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          nvim_lsp_document_symbol = "[LSP-DS]",
          nvim_lsp_signature_help = "[LSP-SH]",
          luasnip = "[Snip]",
          nvim_lua = "[Lua]",
        })
      }
    )
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require('cmp-under-comparator').under,
      kind_cmp,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}
