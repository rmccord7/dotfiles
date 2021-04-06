set nowrap
set smartindent
set expandtab

" Allow the environment to override our indent level,
" otherwise, use the default setup up by configs
if empty($INDENT)
    let c_indent=3
else
    let c_indent=$INDENT
endif

let &tabstop=c_indent
let &softtabstop=c_indent
let &shiftwidth=c_indent
