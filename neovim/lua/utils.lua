local M = {}

-- Merge to lua tables
function M.merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

-- Map commands
function M.map(mode, key, result, options)
    options = M.merge({
        noremap = true,
        silent = false,
        expr = false,
        nowait = false,
    }, options or {})

    if options.buffer then
      options.buffer = nil

      vim.api.nvim_buf_set_keymap(0, mode, key, result, options)
    else
      vim.api.nvim_set_keymap(mode, key, result, options)
    end
end

-- Create an augroup
function M.create_augroup(name, autocmds)
  local group = vim.api.nvim_create_augroup(name, {})

  for _, autocmd in ipairs(autocmds) do
    vim.api.nvim_create_autocmd(
      autocmd[1],
      {
        group = group,
        pattern = autocmd[2],
        command = autocmd[3]
      }
    )
  end
end

-- Create a buffer-local augroup
function M.create_buf_augroup(name, autocmds, bufnr)
  local group = vim.api.nvim_create_augroup(name, {})

  for _, autocmd in ipairs(autocmds) do
    vim.api.nvim_create_autocmd(
      autocmd[1],
      {
        group = group,
        buffer = bufnr,
        command = autocmd[2]
      }
    )
  end
end

-- Automatically create missing directories before save
function M.create_file_directory_structure()
  local path = vim.fn.expand('%:p:h')

  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, 'p')
  end
end

return M

