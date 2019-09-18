if has("conceal")
  setlocal cole=2 cocu=nc
endif


setlocal iskeyword=!-~|         " Includes . and | into words so Tagging works
setlocal splitright             " For opening the tags on the right side

" Only applies to the Tags split window
"50vsplit tags                   " Opening tags
"setlocal nolist
"setlocal nonumber

function! MarkdownFolds()
  let thisline = getline(v:lnum)
  if match(thisline, '^-=') >= 0
    return ">1"
  else
    return "="
  endif
endfunction
setlocal foldmethod=expr
setlocal foldcolumn=1
setlocal foldexpr=MarkdownFolds()


" Moving items up
nmap <silent> <C-k> ddkkp
" Moving items down
nmap <silent> <C-j> ddp
" Opening tags file
nmap <silent> <C-t> :split %:p:h\tags<CR>
