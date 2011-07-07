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

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set hlsearch

filetype plugin on
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python compiler pylint
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

set backspace=2

" Press Space to turn off highlighting and clear any message already
" displayed.
:noremap <silent> <Space> :silent noh<Bar>echo<CR>
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 
set t_Co=256
set mouse=a

:highlight rightMargin term=bold ctermfg=blue guifg=blue
:match rightMargin /.\%>80v/

" Show trailing whitepace and spaces before a tab:
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

"set bg=dark

" Turn on line numbers:
set number
" Toggle line numbers and fold column for easy copying:
noremap <F5> :set nonumber!<CR>:set foldcolumn=0<CR>

nnoremap <F2> :bn<CR>
nnoremap <F3> :bp<CR>
nnoremap <F4> :NERDTreeToggle<CR>
" F6 is used by pep8
let NERDTreeWinPos="right"
let g:pylint_onwrite = 0

filetype plugin indent on

autocmd BufWinEnter .* silent !echo "----\n"`who`"\n"read <afile> at `date` >> ~/.file-log

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

:colorscheme ron
" delek, ron, slate, torte

set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

"Hilight trailing whitespace
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
