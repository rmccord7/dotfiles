require'lightspeed'.setup {
  jump_to_first_match = false,
  highlight_unique_chars = true,
  --cycle_group_fwd_key = '<tab>',
  --cycle_group_bwd_key = '<s-tab>'
}

-- Temp fix for recording macros or executing :normal
--vim.api.nvim_set_keymap('n', 'f', [[reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"]], {noremap = true, expr = true})
--vim.api.nvim_set_keymap('n', 'F', [[reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"]], {noremap = true, expr = true})
--vim.api.nvim_set_keymap('n', 't', [[reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"]], {noremap = true, expr = true})
--vim.api.nvim_set_keymap('n', 'T', [[reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"]], {noremap = true, expr = true})
