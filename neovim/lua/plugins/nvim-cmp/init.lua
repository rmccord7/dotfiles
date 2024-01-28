local config = function()

    local ok, plugin = pcall(require, 'cmp')

    if not ok then
        return
    end

    local types = require('cmp.types')

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

    local config = {
        mapping = {
            ['<C-j>'] = plugin.mapping.select_next_item({ behavior = plugin.SelectBehavior.Insert }),
            ['<C-k>'] = plugin.mapping.select_prev_item({ behavior = plugin.SelectBehavior.Insert }),
            ['<C-d>'] = plugin.mapping.scroll_docs(-4),
            ['<C-f>'] = plugin.mapping.scroll_docs(4),
            ['<C-Space>'] = plugin.mapping.complete({}),
            ['<C-e>'] = plugin.mapping.close(),
            ['<CR>'] = plugin.mapping.confirm({
                select = true,
            }),
        },

        sources = {
            { name = 'luasnip' },
            { name = 'nvim_lsp', },
            { name = 'nvim_lua' },
            { name = 'path' },
        },

        window = {
            completion = plugin.config.window.bordered({
                col_offset = -3,
                side_padding = 0,
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            }),
            documentation = plugin.config.window.bordered({
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            }),
        },

        sorting = {
            comparators = {
                plugin.config.compare.offset,
                plugin.config.compare.exact,
                plugin.config.compare.score,
                require('cmp-under-comparator').under,
                kind_cmp,
                plugin.config.compare.sort_text,
                plugin.config.compare.length,
                plugin.config.compare.order,
            },
        },

    }

    -- Config completion to use symbols from lsp kind
    local lspkind
    ok, lspkind = pcall(require, 'lspkind')

    if ok then
        local formatting = {
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
            end
        }

        config.formatting = formatting
    end


    -- Config completion for lua snippets
    local luasnip
    ok, luasnip = pcall(require, 'luasnip')

    if ok then
        local snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        }

        local mapping = {
            ['<Tab>'] = plugin.mapping(function()
                if plugin.visible() then
                   if luasnip.expand_or_jump() then
                       luasnip.expand_or_jump()
                   end
                end
            end, { "i", "s" }),

            ['<S-Tab>'] = plugin.mapping(function()
                if plugin.visible() then
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end
            end, { "i", "s" }),
        }

        config.snippet = snippet
        config.mapping = vim.tbl_extend('force', config.mapping, mapping)
    end

    -- Setup Cmp
    plugin.setup(config)

    -- Setup Cmp command line
    plugin.setup.cmdline(":", {
        mapping = plugin.mapping.preset.cmdline({
            ["<Tab>"] = plugin.mapping(function(fallback)
                if plugin.visible() then
                    local entry = plugin.get_selected_entry()
                    if not entry then
                        plugin.select_next_item({ behavior = plugin.SelectBehavior.Select })
                    else
                        plugin.confirm()
                    end
                else
                    fallback()
                end
            end, { "i", "s", "c" }),
        }),
        sources = plugin.config.sources({
            { name = "cmdline" },
            { name = "path" },
        }),
        window = {
            completion = plugin.config.window.bordered(),
        },
    })
end

local M = {
    {
        'hrsh7th/nvim-cmp',
        config = config,
        event = {'InsertEnter', 'CmdlineEnter'},
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            "hrsh7th/cmp-cmdline",
            'onsails/lspkind-nvim',
            'saadparwaiz1/cmp_luasnip',
            'lukas-reineke/cmp-under-comparator',
        },
    },
}

return M

