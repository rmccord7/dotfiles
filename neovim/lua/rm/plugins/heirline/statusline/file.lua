M = {}

local utils = require('heirline.utils')

local colors = require('material.colors')

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ':e')
        self.icon, self.icon_color =
            require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    end,
    condition = function(self)
        return not self.filename == ''
    end,
    provider = function(self)
        return self.icon and (self.icon .. ' ')
    end,
    hl = function(self)
        return {
            fg = self.icon_color,
            bg = utils.get_highlight('StatusLine').bg,
        }
    end,
}

local FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ':.')

        if filename == '' then
            return '[No Name]'
        end

        return filename
    end,
    hl = {
        fg = utils.get_highlight('Directory').fg,
        bg = utils.get_highlight('StatusLine').bg,
    },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = '[+]',
        hl = {
            fg = colors.main.green,
            bg = utils.get_highlight('StatusLine').bg,
        },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = ' ',
        hl = {
            fg = colors.main.orange,
            bg = utils.get_highlight('StatusLine').bg,
        },
    },
}

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return {
                fg = colors.main.green,
                bg = utils.get_highlight('StatusLine').bg,
                bold = true,
                force = true,
            }
        end
    end,
}

M.FileSize = {
    provider = function()
        -- stackoverflow, compute human readable file size
        local suffix = { 'B', 'K', 'M', 'G', 'T', 'P', 'E' }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize < 1024 then
            return fsize .. suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format('%.2f%s', fsize / math.pow(1024, i), suffix[i + 1])
    end,
    hl = {
        fg = colors.main.orange,
        bg = utils.get_highlight('StatusLine').bg,
    },
}

-- let's add the children to our FileNameBlock component
M.FileNameBlock = utils.insert(
    FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = '%<' } -- this means that the statusline is cut here when there's not enough space
)

M.FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = {
        fg = utils.get_highlight('Type').fg,
        bg = utils.get_highlight('StatusLine').bg,
        bold = true,
    },
}

M.FileEncoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
        return enc:upper()
    end,
    hl = {
        fg = colors.main.purple,
        bg = utils.get_highlight('StatusLine').bg,
    },
}

M.FileFormat = {
    provider = function()
        local os = vim.bo.fileformat:upper()
        local icon
        if os == 'UNIX' then
            icon = ' '
        elseif os == 'MAC' then
            icon = ' '
        else
            icon = ' '
        end
        return icon .. os
    end,
    hl = {
        fg = colors.main.purple,
        bg = utils.get_highlight('StatusLine').bg,
    },
}

M.FileLastModified = {
    provider = function()
        local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
        return (ftime > 0) and os.date('%c', ftime)
    end,
}

return M
