local config = function()
    local cmp_ok, cmp = pcall(require, 'cmp')
    local luasnip_ok, ls = pcall(require, 'luasnip')
    local lspkind_ok, lspkind = pcall(require, 'lspkind')

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
        Event = '',
        Operator = '',
        TypeParameter = '',
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

    cmp.setup({
        snippet = {
            expand = function(args)
                ls.lsp_expand(args.body)
            end,
        },

        mapping = {
            ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete({}),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                select = true,
            }),
        },

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

        window = {
            completion = cmp.config.window.bordered({
                col_offset = -3,
                side_padding = 0,
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            }),
            documentation = cmp.config.window.bordered({
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            }),
        },

        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. strings[1] .. " "
                kind.menu = "    (" .. strings[2] .. ")"

                return kind
            end,
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
    })
end

local M = {
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = config,
        dependencies = {
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-buffer',
            'amarakon/nvim-cmp-buffer-lines',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'lukas-reineke/cmp-under-comparator',
        },
    },
}

return M

