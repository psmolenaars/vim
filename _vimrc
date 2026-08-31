" My VIMRC

function! CheckFile(path, file)
    if filereadable(a:path.'\'.a:file)
        return 1
    else
        return 0
    endif
endfunction

" Reads local PATH variable and checks all for the supplied exe
function! FindExe(exe)
    let result = 0
    for entry in split($PATH, ';')
        let result = CheckFile(entry, a:exe)
        if result
            break
        endif
    endfor
    return result
endfunction

"Comment and uncomment v2.0
function! ToggleCommentV2(...)
    let cchar = a:0 > 0 ? a:1 : substitute(&commentstring, '%s', "", "")
    let startpos = getpos("v")[1]

    for line in split(startpos,"\n")
        let current_text = getline(line)

        if current_text =~ '^\s*' . escape(cchar, '\/*^$.~[]')
            call setline(line, substitute(current_text, escape(cchar, '\/*^$.~[]'), '', ''))
        else
            call setline(line, substitute(current_text, '^\s*', '&' . cchar, ''))
        endif
    endfor
endfunction

" Comments or uncomments a visual selected line
function! ToggleComment(cchar)
    let startpos = getpos("v")[1]
    for line in split(startpos,"\n")
        let char = matchstr(getline('.'), a:cchar)
        if char == a:cchar
            :execute ":normal! " . line . "Gx"
        else
            :execute ":normal! " . line . "GI" . a:cchar
        endif
    endfor
endfunction

function! ScratchBuffer()
        split Scratch
        setlocal buftype=nofile
        setlocal bufhidden=hide
        setlocal noswapfile
        startinsert
endfunction

function! BufferList()
  let l:list = ' Buffers: '
  for l:i in range(1, bufnr('$'))
    if buflisted(l:i)
      let l:name = fnamemodify(bufname(l:i), ':t')
      let l:name = (l:name == '') ? '[No Name]' : l:name

      " Voeg een visueel sterretje (*) toe aan het actieve bestand
      if l:i == bufnr('%')
        let l:list .= '[' . l:i . ':' . l:name . '*]' . ' '
      else
        let l:list .= ' ' . l:i . ':' . l:name . ' '
      endif
    endif
  endfor
  return l:list
endfunction

" Adjust the statusbar
set laststatus=2
set statusline=
set statusline +=%.20t\ 
set statusline +=%r
set statusline +=%m
set statusline +=%=
set statusline +=%#CursorLine#
set statusline +=\ 
set statusline +=%{&ff}
set statusline +=\ 
set statusline +=%#Pmenu#
set statusline +=\ 
set statusline +=%{&enc}
set statusline +=\ 
set statusline +=%#CursorLine#
set statusline +=\ 
set statusline +=%.l
set statusline +=:
set statusline +=%.c
set statusline +=\ 
set statusline +=%#PmenuMatch#
set statusline +=\ 
set statusline +=%.p%%\ 

" General
colorscheme slate
syntax on
filetype plugin on
set autoindent
set number
set relativenumber
set history=250
set tabstop=4
set ignorecase
set hlsearch
set incsearch
set listchars=eol:$,trail:.,nbsp:_,tab:>-
set list
set scrolloff=5
set encoding=utf-8
set mouse=a
set hidden
set wildmenu
set wildmode=longest:full,full
set path+=**

" gVim specific (windows)
set guioptions-=m               " Remove menu bar
set guioptions-=T               " Remove toolbar
set guioptions-=r               " Remove right-hand scroll bar
set guioptions-=L               " Remove left-hand scroll bar
set backspace=2                 " Restores backspace function
set completeopt=menuone         " Show completion menu on 1 item

set guifont=Cascadia_Mono:h12:cANSI:qDRAFT

set dir=$USERPROFILE\\AppData\\Local\\Temp
cd $USERPROFILE\\Documents
let $RC = "~\\_vimrc"
let $RC = $MYVIMRC

" New Windows fixes for netrw
let g:netrw_cygwin = 0
let g:netrw_silent = 1
let g:netrw_use_errorwindow = 0

" Key mappings
let mapleader = ","
nnoremap <leader>hl :nohlsearch<CR>
noremap <leader>sb :call ScratchBuffer()<CR>
noremap <leader>c :call ToggleCommentV2()<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"Language specific commands
"autocmd FileType vim noremap <leader>c :call ToggleCommentV2()<CR>

"Python specific
augroup filetype_python
    autocmd!
    autocmd FileType python let maplocalleader = ","
    "autocmd FileType python noremap <localleader>c :call ToggleComment("#")<CR>
    autocmd FileType python setlocal fileformat=unix
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal colorcolumn=79
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal textwidth=99
    autocmd FileType python setlocal nofoldenable
augroup END

" Bind python and pylint if available
if FindExe('python.exe')
    nnoremap <F5> :!start python %<CR>
    let lint_path = $APPDATA.'\Python\Python37\Scripts\'
    if FindExe('pylint.exe')
        nnoremap <F4> :!start pylint.exe %<CR>
    elseif CheckFile(lint_path, 'pylint.exe')
        nnoremap <F4> :execute "!start cmd /k ".lint_path."\pylint %"<CR>
    endif
endif

" VimCode Changes
let g:netrw_banner = 0       " Hide the large, cluttered help text at the top
let g:netrw_liststyle = 3    " Use 'tree' view (allows folders to expand/collapse)
"let g:netrw_winsize = 25     " Set the sidebar width to 25% of the screen
let g:netrw_mousemaps = 1    " Map double-click to execute that default choice
