local M = {}

-- Merge to lua tables
function M.merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

-- Map commands
function M.map(modes, key, result, options)
    options = M.merge({
        noremap = true,
        silent = false,
        expr = false,
        nowait = false,
    }, options or {})

    local buffer = options.buffer
    options.buffer = nil

    if type(modes) == "string" then
      if modes == '' then
        modes = {}
      else
        modes = { modes }
      end
    end

    for i = 1, #modes do
        if buffer then
            vim.api.nvim_buf_set_keymap(0, modes[i], key, result, options)
        else
            vim.api.nvim_set_keymap(modes[i], key, result, options)
        end
    end
end

-- Create an augroup
function M.create_augroup(autocmds, name)
  vim.cmd('augroup ' .. name)
  vim.cmd('autocmd!')

  for _, autocmd in ipairs(autocmds) do
    vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
  end

  vim.cmd('augroup END')
end

-- Create a buffer-local augroup
function M.create_buf_augroup(autocmds, name, bufnr)
  local buftext

  vim.cmd('augroup ' .. name)

  if bufnr then
    buftext = string.format("<buffer=%d>", bufnr)
  else
    buftext = "<buffer>"
  end

  vim.cmd('autocmd! * ' .. buftext)

  for _, autocmd in ipairs(autocmds) do
   vim.cmd(string.format("autocmd %s %s %s", autocmd[1], buftext, table.concat(autocmd, ' ', 2)))
  end

  vim.cmd('augroup END')
end

-- Automatically create missing directories before save
function M.create_file_directory_structure()
  local path = vim.fn.expand('%:p:h')

  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, 'p')
  end
end

return M

