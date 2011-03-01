"
" Configuration de VIM
"

" source the .vimrc file on save to apply all changes immediately
if has("autocmd")
   autocmd! bufwritepost .vimrc source ~/.vimrc
endif

set mouse=a
set encoding=utf-8
set fileencoding=utf-8
set nocompatible  " Utilise les spécificités de VIM
set shiftwidth=8
set nobackup " Pas de sauvegarde ~
set backspace=2
set visualbell
set bg=dark
set directory=.,$TEMP
" set textwidth=80

" Indentation
syntax on
set autoindent
au bufenter *.py set et ts=4
au BufWinEnter *.py let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
au BufWinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)


" C
set noexpandtab
set softtabstop=8
set cinoptions=>8

autocmd BufEnter *.c,*.h,*.cpp set smartindent cindent
au BufEnter    ~/tmp/mutt-*   :silent %g/^> -- $/,/^-- $/-1d

" Git diff on commit
au BufRead,BufNewFile COMMIT_EDITMSG     setf git

" set cinoptions=>4^-2:2
autocmd BufWrite * silent! %s/[\r \t]\+$// " Remove trailing spaces
set showmatch
set scrolloff=5
set wrap
set showbreak=+
set hidden

" Search
set smartcase
set incsearch
set hlsearch

" Menu de navigation dans les fichiers
set wildmenu

" Menu de navigation avec list complète de fichiers du répertoire
set wildmode=list:full

" Barre d'état
set ruler

" Barre d'état omniprésente
set laststatus=2

" Barre d'état personnalisée
set statusline=%<%f%h%m%r\ \ [%n]%=%b\ 0x%B\ \ \ \ %c%V,%l\ %P

" Sauvegarde automatiquement le fichier si on fait une compilation
set autowrite

" Fenêtres de tailles différentes
set noequalalways

" La completion se fait dans le path suivant
set path=.,..,~/usr/local/include,~/usr/include,/usr/local/include,/usr/include,/home/feth/projets/edw-trunk-src

" Touche pour appeler les maps
let mapleader="_"

" Show line number :
set nu

""""""""""""""""""""""""""""""""""""""""""""""""""
"Nom du fichier en cours dans l'onglet pour Vim
""""""""""""""""""""""""""""""""""""""""""""""""""
function! ShortTabLine()
    let ret = ''
    for i in range(tabpagenr('$'))
	"Select the color group for highlighting active tab
	if i + 1 == tabpagenr()
	    let ret .= '%#errorMsg#'
	else
	    let ret .= '%#Tab#'
	endif

	"Find the buffername for the tablabel
	let buflist = tabpagebuflist(i+1)
	let winnr = tabpagewinnr(i+1)
	let buffername = bufname(buflist[winnr - 1])
	let filename = fnamemodify(buffername, ':t')
	"Check if there is no name
	if filename == ''
	    let filename = 'noname'
	endif
        for bufnr in buflist
            if getbufvar(bufnr, "&modified")
              let filename = '!'.filename
              break
            endif
        endfor
	"Only show the first 18 letters of the name and
	".. if the filename is more than 20 letters long
	if strlen(filename) >= 18
	    let ret .= '['.filename[0:17].'..]'
	else
	    let ret .= '['.filename.']'
	endif
    endfor

    "After the last tab fill with TabLineFill and reset tab page #
    let ret .= '%#TabLineFill#%T'
    return ret
endfunction

set tabline=%!ShortTabLine()

""""""""""""""""""""""""""""""""""""""""""""""""""
"Omni-completion par CTRL-X_CTRL-O
"""""""""""""""""""""""""""""""""""""""""""""""""""
au filetype html        set omnifunc=htmlcomplete#CompleteTags
au filetype css         set omnifunc=csscomplete#CompleteCSS
au filetype javascript  set omnifunc=javascriptcomplete#CompleteJS
au filetype c           set omnifunc=ccomplete#Complete
au filetype php         set omnifunc=phpcomplete#CompletePHP
au filetype ruby        set omnifunc=rubycomplete#Complete
au filetype sql         set omnifunc=sqlcomplete#Complete
au filetype python      set omnifunc=pythoncomplete#Complete
au filetype xml         set omnifunc=xmlcomplete#CompleteTags

""""""""""""""""""""""""""""""""""""""""""""""""""
"Personnalisation de la barre de statut
"""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%t%m%r%h%w\ Line:\ %4l,\ Col:\ %4v\ [%p%%]\ Len:\ %L

" Efface le highlight après une recherche
map ¤ :nohlsearch<CR>

" <F1> : aide (défaut)

" <F2> : cast la ligne
map <F2> gqq

" <F3> : compilation
map <F3> :execute "w"<Bar>make %:r<RETURN>

" <F4> : fichier précédent
map <F4>  :previous<C-M>

" <F5> : fichier suivant
map <F5>  :next<C-M>

" <F6> : bascule clair / foncé pour la coloration syntaxique
map <F6> :if (&bg=="dark")<Bar>se bg=light<Bar>
        \else<Bar>se bg=dark<Bar>endif<Bar>
        \syn off<Bar>syn on<CR>

" <F7> : bascule syntaxe on / off
map <F7> :if exists("syntax_on")<Bar>syn off<Bar>
        \else<Bar>syn on<Bar>endif<CR>

" <F8> ; tampon d'édition précédent
map <F8>  :bp<C-M>

" <F9> ; tampon d'édition suivant
map <F9>  :bn<C-M>

" <F10> : suppression du tampon d'édition courant
map <F10> :bd<C-M>

" <F11> : bascule en mode collage à l'identique
set pastetoggle=<F11>

map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" I need another Esc key
"inoremap <Tab> <Esc>
"vnoremap <Tab> <Esc>
inoremap <S-Tab> <Tab>
vnoremap <S-Tab> <Tab>
inoremap <S-Return> <Esc>
vnoremap <S-Return> <Esc>
inoremap <M-Return> <Esc>
vnoremap <M-Return> <Esc>
inoremap <C-Space> <Esc>
vnoremap <C-Space> <Esc>

" lazy scrolling
noremap <BS> <C-u>
noremap <Space> <C-d>
noremap <C-BS> <C-u>
noremap <C-Space> <C-d>
noremap <Return> zz

" lazy code folding / unfolding
noremap <Tab> za
noremap <S-Tab> zA

" switching / moving / creating tabs
noremap g<Tab> gt
noremap g<S-Tab> gT
noremap <C-Tab> gt
noremap <C-S-Tab> gT
noremap <C-PageUp> :exe "silent! tabmove " . (tabpagenr() - 2)<CR>
noremap <C-PageDown> :exe "silent! tabmove " . tabpagenr()<CR>
noremap <C-n> :exe "silent! tabnew"<CR>:exe "silent! Ex"<CR>

" Show all nbsp in red
highlight NBSP ctermbg=red guibg=red
match NBSP / /

" Abréviations courantes
" :source ~/.vim/abbreviate

" Enable omnicppcompletion
set nocp
filetype plugin on
set path=.,..,/usr/local/include,/usr/include

" XML folding
au BufNewFile,BufRead *.xml,*.htm,*.html so /home/feth/.vim/ftplugin/XMLFolding.vim

