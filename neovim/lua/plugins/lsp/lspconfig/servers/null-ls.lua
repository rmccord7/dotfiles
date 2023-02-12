local ok, null_ls = pcall(require, 'null-ls')

if not ok then
    return
end

local with_root_file = function(...)
    local files = { ... }
    return function(utils)
        return utils.root_has_file(files)
    end
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local _M = {}

_M.setup = function(on_attach)
    null_ls.setup({
        sources = {
            diagnostics.yamllint,
            diagnostics.jsonlint,
            diagnostics.shellcheck,

            formatting.stylua,
            formatting.shfmt.with({
                filetypes = { 'sh', 'bash', 'zsh' },
            }),
            formatting.rustfmt,
        },
        on_attach = on_attach,
    })
end

return _M
