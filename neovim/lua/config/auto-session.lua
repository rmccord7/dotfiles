vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"

require('auto-session').setup {
  auto_session_enable_last_session = true,
  auto_session_enabled = true,
  auto_save_enabled = true,
}