local ok, trouble = pcall(require, 'nvim-trouble')

if not ok then
    return
end

trouble.setup({})
