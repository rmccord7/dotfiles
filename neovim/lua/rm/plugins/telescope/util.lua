M = {}

M.ignored_files = {
  -- Directories
  "%.git/.*",

  -- Clangd
  "%.cache/*",

  -- FileTypes
  "$%.ttf",
  "$%.svg",
  "$%.png",
  "$%.jpeg",
  "$%.jpg",
  "$%.ico",

  -- Files
  "tags",

  -- Output files
  "$%.o",
  "$%.a",
  "$%.lib",
  "$%.so",
  "$%.bin",
  "$%.elf",
  "$%.dblite",
  "$%.pyc",
}

function M.builtin(lhs, picker, label)
  local opts = {
    prompt_title = label,
  }
  vim.keymap.set({"n"}, lhs, function()
    require("telescope.builtin")[picker](opts)
  end, { desc = label })
end

function M.custom(lhs, picker, label, opts)
  local default = {
    prompt_title = label,
  }
  opts = vim.tbl_extend("keep", opts or {}, default)
  vim.keymap.set({"n"}, lhs, function()
    require("telescope.builtin")[picker](opts)
  end, { desc = label })
end

function M.path_from_cwd()
  local cwd = vim.fn.getcwd()

  cwd = cwd:gsub(cwd, "")
  cwd = require("rm.util.path").os_path(cwd)

  return cwd or ""
end

return M
