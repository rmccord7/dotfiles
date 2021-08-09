require('kommentary.config').configure_language("c", {
  prefer_multi_line_comments = true,
})

local config = require('kommentary.config')

--[[ This function will be called automatically by the mapping, the first
argument will be the line that is being operated on. ]]
function insert_comment_above(...)
    local args = {...}
	--
    -- This includes the commentstring
    local configuration = config.get_config(0)
    local line_number = args[1]
	--
    -- Get the current content of the line
    local content = vim.api.nvim_buf_get_lines(0, line_number-1, line_number, false)[1]
	--j
    --[[ Get the level of indentation of that line (Find the index of the
    first non-whitespace character) ]]
    local indentation = string.find(content, "%S")
	--
    --[[ Create a string with that indentation, with a dot at the end so that
    kommentary respects that indentation ]]
    local new_line = string.rep(" ", indentation-1) .. "."
	--
    -- Insert the new line above the current one
    vim.api.nvim_buf_set_lines(0, line_number-1, line_number-1, false, {new_line})
	--
    -- Comment in the new line
    require('kommentary.kommentary').comment_in_range(line_number, line_number, configuration)
	--
    -- Set the cursor to the correct position
    vim.api.nvim_win_set_cursor(0, {vim.api.nvim_win_get_cursor(0)[1]-1, #new_line+2})
	--
    -- Change the char under cursor (.)
    vim.api.nvim_feedkeys("r.i", "n", false)
end

--[[ This is a method provided by kommentary's config, it will take care of
setting up a <Plug> mapping. The last argument is the optional callback
function, meaning when we execute this mapping, this function will be
called instead of the default. --]]
config.add_keymap("n", "kommentary_insert_above", config.context.line, {}, "insert_comment_above")

-- Set up a regular keymapping to the new <Plug> mapping
vim.api.nvim_set_keymap('n', '<leader>cO', '<Plug>kommentary_insert_above', { silent = true })

