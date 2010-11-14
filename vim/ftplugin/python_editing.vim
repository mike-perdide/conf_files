" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
finish
endif
let b:did_ftplugin = 1

map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
map <buffer> gd /def <C-R><C-W><CR> 

hi ErrorMsg guifg=white guibg=#FF6C60 gui=BOLD ctermfg=black ctermbg=yellow cterm=NONE
hi WarningMsg guifg=white guibg=#FF6C60 gui=BOLD ctermfg=white ctermbg=blue cterm=NONE
:au BufWinEnter * let w:m2=matchadd('WarningMsg', '\%>80v.\+', -1)
:au BufWinEnter * let w:m2=matchadd('ErrorMsg', '[\x00-\x1f\x80-\xff]', -1)

set foldmethod=expr
set foldexpr=PythonFoldExpr(v:lnum)
set foldtext=PythonFoldText()

map <buffer> f za
map <buffer> F :call ToggleFold()<CR>
let b:folded = 1

function! ToggleFold()
    if( b:folded == 0 )
        exec "normal! zM"
        let b:folded = 1
    else
        exec "normal! zR"
        let b:folded = 0
    endif
endfunction

function! PythonFoldText()

    let size = 1 + v:foldend - v:foldstart
    if size < 10
        let size = " " . size
    endif
    if size < 100
        let size = " " . size
    endif
    if size < 1000
        let size = " " . size
    endif

    if match(getline(v:foldstart), '"""') >= 0
        let text = substitute(getline(v:foldstart), '"""', '', 'g' ) . ' '
    elseif match(getline(v:foldstart), "'''") >= 0
        let text = substitute(getline(v:foldstart), "'''", '', 'g' ) . ' '
    else
        let text = getline(v:foldstart)
    endif
    
    return size . ' lines:'. text . ' '

endfunction

function! PythonFoldExpr(lnum)

    if getline(a:lnum) =~ '^\ *\(def\|class\)\ *\s'
"        echo "0"
        return 0
    endif

    if getline(a:lnum-1) =~ '^\ *\(def\|class\)\ *\s'
"        echo "1"
        return 1
    endif

    if indent(a:lnum) != 0
"        echo "First ="
        return "="
    endif

    if getline( nextnonblank(a:lnum) ) =~ '^\ *\(def\|class\)\ *\s'
"        echo "0"
        return '0'
    endif

"    echo "Final ="
    return "="

endfunction

" In case folding breaks down
function! ReFold()
    set foldmethod=expr
    set foldexpr=0
    set foldnestmax=1
    set foldmethod=expr
    set foldexpr=PythonFoldExpr(v:lnum)
    set foldtext=PythonFoldText()
    echo 
endfunction

