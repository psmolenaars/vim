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

" Comments or uncomments a visual selected line
function! ToggleComment(char)
    let startpos = getpos("v")[1]
    for line in split(startpos,"\n")
        let char = matchstr(getline('.'), a:char)
        if char == "#"
            :execute ":normal! " . line . "Gx"
        else
            :execute ":normal! " . line . "GI" . a:char
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

" Adjust the statusbar
set laststatus=2
set statusline=
set statusline +=%.20t\ 
set statusline +=%r
set statusline +=%m
set statusline +=%=
set statusline +=%{&ff}
set statusline +=\ \|\ 
set statusline +=%{&enc}
set statusline +=\ \|\ 
set statusline +=%3.p%%
set statusline +=\ \|
set statusline +=%3.l
set statusline +=:
set statusline +=%-3.c

" General
syntax on
filetype plugin on
"colorscheme base16-default-dark
set autoindent
set number
set history=250
set tabstop=4
set ignorecase
"set guifont=Bitstream\ Vera\ Sans\ Mono:h10
set hlsearch
set incsearch
set listchars=eol:¦,trail:~,nbsp:_,tab:>-
set list
set scrolloff=5
set encoding=utf-8
set cursorline
set mouse-=a
set hidden
set wildmenu
set splitright
set splitbelow

" gVim specific (windows)
"set guioptions-=m               " Remove menu bar
"set guioptions-=T               " Remove toolbar
"set guioptions-=r               " Remove right-hand scroll bar
"set guioptions-=L               " Remove left-hand scroll bar
"set backspace=2                 " Restores backspace function
"set completeopt=menuone         " Show completion menu on 1 item
"set lines=35
"set dir=$USERPROFILE\\AppData\\Local\\Temp
"cd $USERPROFILE\\Documents

" Key mappings
let mapleader = ","
nnoremap <leader>hl :nohlsearch<CR>
noremap <leader>sb :call ScratchBuffer()<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

let $RC = $MYVIMRC

" Python specific
augroup filetype_python
    autocmd!
    autocmd FileType python let maplocalleader = ","
    autocmd FileType python noremap <localleader>c :call ToggleComment("#")<CR>
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
"if FindExe('python.exe')
"    nnoremap <F5> :!start python %<CR>
"    let lint_path = $APPDATA.'\Python\Python37\Scripts\'
"    if FindExe('pylint.exe')
"        nnoremap <F4> :!start pylint.exe %<CR>
"    elseif CheckFile(lint_path, 'pylint.exe')
"        nnoremap <F4> :execute "!start cmd /k ".lint_path."\pylint %"<CR>
"    endif
"endif
