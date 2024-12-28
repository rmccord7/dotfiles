-- Debug print
_G.dump = function(obj, use_notify)
  if use_notify then
    vim.notify(obj, vim.log.levels.DEBUG, { timeout = false })
  else
    print(vim.inspect(obj))
  end
  return obj
end
