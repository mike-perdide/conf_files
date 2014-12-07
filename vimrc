" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes) in terminals
set bg=dark

"set expandtab
"set softtabstop=4
"set tabstop=4
"set shiftwidth=4
"set backspace=2
set hlsearch

filetype plugin on
filetype plugin indent on

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python compiler pylint
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Press Space to turn off highlighting and clear any message already
" displayed.
noremap <silent> <Space> :silent noh<Bar>echo<CR>

" Automatically save the position in the file.
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

set t_Co=256

highlight rightMargin term=bold ctermfg=blue guifg=blue
match rightMargin /.\%>79v/

" Turn on line numbers:
set number
" Toggle line numbers and fold column for easy copying:
noremap <F5> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <F4> :NERDTreeToggle<CR>

" F6 is used by pep8
let NERDTreeWinPos="right"
let g:pylint_onwrite = 0

"autocmd BufWinEnter .* silent !echo "----\n"`who`"\n"read <afile> at `date` >> ~/.file-log

inoremap <Esc>Oq 1
inoremap <Esc>Or 2
inoremap <Esc>Os 3
inoremap <Esc>Ot 4
inoremap <Esc>Ou 5
inoremap <Esc>Ov 6
inoremap <Esc>Ow 7
inoremap <Esc>Ox 8
inoremap <Esc>Oy 9
inoremap <Esc>Op 0
inoremap <Esc>On .
inoremap <Esc>OQ /
inoremap <Esc>OR *
inoremap <Esc>Ol +
inoremap <Esc>OS -

vnoremap <Esc>Oq 1
vnoremap <Esc>Or 2
vnoremap <Esc>Os 3
vnoremap <Esc>Ot 4
vnoremap <Esc>Ou 5
vnoremap <Esc>Ov 6
vnoremap <Esc>Ow 7
vnoremap <Esc>Ox 8
vnoremap <Esc>Oy 9
vnoremap <Esc>Op 0
vnoremap <Esc>On .
vnoremap <Esc>OQ /
vnoremap <Esc>OR *
vnoremap <Esc>Ol +
vnoremap <Esc>OS -

noremap <Esc>Oq 1
noremap <Esc>Or 2
noremap <Esc>Os 3
noremap <Esc>Ot 4
noremap <Esc>Ou 5
noremap <Esc>Ov 6
noremap <Esc>Ow 7
noremap <Esc>Ox 8
noremap <Esc>Oy 9
noremap <Esc>Op 0
noremap <Esc>On .
noremap <Esc>OQ /
noremap <Esc>OR *
noremap <Esc>Ol +
noremap <Esc>OS -

colorscheme ron
" delek, ron, slate, torte

set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

"Hilight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$/

let g:loaded_matchparen=1

" Setting the right option for MiniBufExplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerDebugLevel = 10

" set listchars=tab:>\
highlight NBSP ctermbg=red guibg=red
execute pathogen#infect()

au bufenter *.sls set filetype=yaml
au bufenter *.sls set ts=2
au bufenter *.sls set shiftwidth=2
"
" Show all nbsp in red
highlight NBSP ctermbg=red guibg=red
match NBSP / / 
