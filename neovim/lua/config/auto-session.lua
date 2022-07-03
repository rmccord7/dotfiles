local ok, autosession = pcall(require, "auto-session")

if not ok then
    return
end

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

autosession.setup {
  auto_session_enable_last_session = true,
  auto_session_enabled = true,
  auto_save_enabled = true,
}
