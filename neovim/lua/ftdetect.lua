vim.filetype.add({
    extension = {
        h = 'c',
        scons = 'python',
        api = 'python',
    },
    filename = {
        ['.clangd'] = 'yaml',
    },
    pattern = {
        ['.*/sway/config%.d/.*'] = {'swayconfig', priority = 10},
    },
})

