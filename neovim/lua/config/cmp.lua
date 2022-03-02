local lspkind = require('lspkind')
local cmp = require('cmp')
local types = require "cmp.types"

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
      -- You must install `vim-vsnip` if you use the following as-is.
      vim.fn['vsnip#anonymous'](args.body)
    end
  },

  -- You must set mapping if you want.
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
    ['<C-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), '')
      else
        fallback()
      end
    end,
  },

  -- You should specify your *installed* sources.
  sources = {
    { name = 'vsnip' },
    --{ name = 'treesitter' },
    { name = 'nvim_lsp' },
    --{ name = 'buffer' },
    { name = 'tags' },
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
          vsnip = "[vsnip]",
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
