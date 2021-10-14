local lspkind = require('lspkind')
local cmp = require('cmp')

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
    { name = 'treesitter' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'tags' },
    { name = 'nvim_lua' },
    { name = 'path' },
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]

      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        vsnip = "[vsnip]",
        nvim_lua = "[Lua]",
      })[entry.source.name]

      return vim_item
    end
  },
}
