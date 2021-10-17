call plug#begin('~/.local/share/nvim/plugged')

"Plug 'davidhalter/jedi-vim'
"Plug 'zchee/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'nvie/vim-flake8'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sonph/onehalf', { 'rtp': 'vim' }

"Plug 'tmhedberg/SimpylFold'

call plug#end()

""""" Color scheme
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
" Fix folded highlighted
hi Folded ctermbg=0
" Fix coc-pyright popup
hi FgCocErrorFloatBgCocFloating ctermfg=94 ctermbg=253

let g:neomake_python_enabled_makers = ['flake8']

" turn on rope
let g:pymode_rope = 1

" turn on completion?
let g:pymode_rope_completion = 1
let g:pymode_rope_goto_definition_bind = "<\-d>"

set completeopt=menu
set showmatch
set ts=4
set sts=4
set sw=4
set autoindent
set smartindent
set smarttab
set expandtab
set number
set mouse=a

set hlsearch
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set autowrite		" Automatically save before commands like :next and :make

autocmd BufWinLeave *.* silent! mkview
autocmd BufWinEnter *.* silent! loadview

set tags=tags
autocmd BufWritePost *.py silent! !ctags -R --python-kinds=-i --languages=python&;

" COC configuration
"set cmdheight=2
let g:coc_global_extensions = ['coc-yaml', 'coc-git', 'coc-pyright']


""""""""""""""""""""""""""""""""""""""""""" Python folding
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

"    if getline( nextnonblank(a:lnum) ) =~ '^\ *\(def\|class\)\ *\s'
"        echo "0"
"        return '0'
"    endif

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

map <buffer> <S-e> :w<CR>:!python3 % <CR>
map <buffer> gd /def <C-R><C-W><CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
