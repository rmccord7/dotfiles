-- Global table with all my user-created aucmds
_G.Augroups = {}

-- Helper for creating a new augroup and autocmds along with a toggler
_G.create_augroup = function(group, aucmds)
  -- Create new augroup
  vim.api.nvim_create_augroup(group, {
    clear = true,
  })

  -- Create this augroup's entry in the global table if it doesn't exist
  if not _G.Augroups[group] then
    _G.Augroups[group] = {
      enabled = true,
      aucmds = aucmds,
    }
  end

  -- Loop through the table of aucmds and create each one
  for _, aucmd in ipairs(aucmds) do
    -- Add the current augroup name to the autocmd config table
    local aucmd_config = vim.tbl_extend("keep", { group = group }, aucmd)

    -- Remove events key from config to pass to autocmd API function
    aucmd_config.events = nil
    vim.api.nvim_create_autocmd(aucmd.events, aucmd_config)
  end
end

--- Helper function to toggle an augroup on/off
--- @param group string name of autogroup to toggle
--- @param show_notify boolean if true don't show notification (default false)
_G.toggle_augroup = function(group, show_notify)
  if _G.Augroups[group].enabled then
    _G.Augroups[group].enabled = false
    vim.api.nvim_del_augroup_by_name(group)
    if not show_notify then
      vim.notify("Disabled " .. group)
    end
  else
    _G.Augroups[group].enabled = true
    create_augroup(group, _G.Augroups[group].aucmds)
    if not show_notify then
      vim.notify("Disabled " .. group)
    end
    vim.notify("Enabled " .. group)
  end
end

-- quickly print a lua table to :messages
_G.dump = function(obj, use_notify)
  if use_notify then
    vim.notify(obj, vim.log.levels.DEBUG, { timeout = false })
  else
    print(vim.inspect(obj))
  end
  return obj
end

return M
