--Use hybrid numbers in normal mode and
--absolute line numbers in insert mode.
create_augroup("HYBRID_NUM_AUCMDS", {
  {
    events = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
    pattern = "*",
    command = 'if &nu && mode() != "i" | set rnu   | endif',
  },
  {
    events = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
    pattern = "*",
    command = "if &nu | set nornu | endif",
  },
  {
    events = { "TermOpen" },
    pattern = "*",
    command = "startinsert",
  },
  {
    events = { "TermOpen" },
    pattern = "*",
    command = ":set nonumber norelativenumber",
  },
  { events = { "TermOpen" }, pattern = "*", command = "nnoremap <buffer> <C-c> i<C-c>" },
})

-- Create directory on save if it doesn't exist.
create_augroup("CREATE_DIR_AUCMDS", {
  events = { "BufWritePre" },
  pattern = "*",
  command = 'lua require("utils").create_file_directory_structure()',
})

-- Autocmds
-- highlight yank for a brief second for visual feedback
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ on_visual = false })
  end,
})

create_augroup("window_group", {
  {
    events = { "VimResized" },
    desc = "Automatically resize windows in all tabpages when resizing Vim",
    command = "tabdo wincmd =",
  },
  {
    events = { "BufEnter" },
    desc = "When :q, close if quickfix is the only window",
    callback = function()
      if vim.bo.filetype == "qf" and vim.fn.winnr("$") < 2 then
        vim.cmd.quit()
      end
    end,
  },
  {
    events = { "FileType" },
    pattern = "qf",
    desc = "Skip quickfix windows when :bprevious and :bnext",
    command = "set nobuflisted",
  },
  {
    events = { "QuitPre" },
    desc = "Auto close corresponding loclist when quitting a window",
    callback = function()
      if vim.bo.filetype ~= "qf" then
        vim.cmd("silent! lclose")
      end
    end,
    nested = true,
  },
})

-- Turn terminal to normal mode with escape if it's not a lazygit terminal
create_augroup("REMAP_TERM_ESCAPE_UNLESS_LAZYGIT", {
  events = "TermOpen",
  pattern = "*",
  callback = function()
    if vim.fn.expand("%:t", false) ~= "lazygit" then
      vim.keymap.set({"t"}, "<esc>", [[<c-\><c-n>]], { desc = "Escape term" })
    end
  end,
})
