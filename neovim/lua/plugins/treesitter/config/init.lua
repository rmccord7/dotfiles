local KB_SIZE = 1024

local M = {}

-- For unhandled file types
local default_ft = {
    size = 75 * KB_SIZE,
    lc = 75000,
}

-- For unhandled languages
local default_lang = {
    __index = function()
        return(default_ft)
    end
}

M.lang = {}

setmetatable(M.lang, default_lang)

local ft = {
    c = {
        size = 75 * KB_SIZE,
        lc = 75000
    }
}

return M
