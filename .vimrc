call plug#begin('~/.vim/plugged')

	Plug 'preservim/nerdtree'
	Plug 'preservim/tagbar'
	Plug 'vim-airline/vim-airline'
"	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'sheerun/vim-polyglot'
	Plug 'arcticicestudio/nord-vim'
	Plug 'SirVer/ultisnips'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "  Plug 'scrooloose/syntastic'
	Plug 'hdiniz/vim-gradle'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"	Plug 'dense-analysis/ale'
	Plug 'junegunn/fzf.vim'
	Plug 'artur-shaik/vim-javacomplete2'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"	if has('nvim')
"		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"	else
" 		Plug 'Shougo/deoplete.nvim'
"		Plug 'roxma/nvim-yarp'
"  		Plug 'roxma/vim-hug-neovim-rpc'
"	endif
call plug#end()

nmap <F9> :NERDTreeToggle ~/IdeaProjects
nmap <F8> :TagbarToggle
nmap <F10> :NERDTreeToggle % 

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Find and Replace
map <leader>fr :%s///g<left><left> " Find and replace. \fr
map <leader>frl :s///g<left><left> " Find and replace (current line only) \frl
set background=dark
colorscheme nord
set termguicolors
let g:coc_global_extensions = ['coc-solargraph', 'coc-java']

" Use fzf as a file finder
nnoremap <C-p> :Files ~/IdeaProjects<CR>

command! -nargs=1 Gr :call SearchInAllFiles(<q-args>) 
function! SearchInAllFiles(keyword)
	let current_root = fnamemodify(finddir('.git', expand('%:p:h') . ';'), ':h')
	let extention = '*'
	if empty(current_root)
		let current_root = '~/IdeaProjects'
	endif
	if stridx(expand('%'), '.') != 0
		let extention = '*.' . expand('%:e')
	endif
	let cleaned_keyword = substitute(a:keyword, "'", "", "g")
	" exe 'grep /' . cleaned_keyword . '/ ' . current_root . '/**/' . extention
	call fzf#vim#grep('grep /' . cleaned_keyword . '/ ' . current_root . '/**/' . extention)

endfunction

nmap bb *  

" vim config
set ts=4 " How many columns of whitespace a \t is worth
set shiftwidth=4 " How many columns of whitespace a "level of indentation" is worth
set autoindent
set cindent
set nu " Enable line numbers
set hlsearch " Enable highlight search
set showmatch
set ruler
set laststatus=2
set noswapfile
set mouse=a " Enable mouse drag on window splits
set clipboard=unnamedplus " set clipboard to default
set ignorecase
filetype plugin on
set path=~/IdeaProjects/**
set foldmethod=indent
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.
set foldcolumn=1
set ai

let g:airline#extensions#tabline#enabled = 1              " vim-airline 버퍼 목록 켜기
let g:airline#extensions#tabline#fnamemod = ':t'          " vim-airline 버퍼 목록 파일명만 출력
let g:airline#extensions#tabline#buffer_nr_show = 1       " buffer number를 보여준다
let g:airline#extensions#tabline#buffer_nr_format = '%s:' " buffer number format

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['plugged/ultisnips']
let NERDTreeShowHidden=1
let g:tagbar_sort = 0

nnoremap <C-S-t> :enew<Enter>         " 새로운 버퍼를 연다
nnoremap <C-F5> :bprevious!<Enter>    " 이전 버퍼로 이동
nnoremap <C-F6> :bnext!<Enter>        " 다음 버퍼로 이동
nnoremap <C-F4> :bp <BAR> bd #<Enter> " 현재 버퍼를 닫고 이전 버퍼로 이동


" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u starts a new undo break, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

if has("syntax")
	syntax on " Enable syntax highlighting
endif

" --- javacomplete2
" -- Java completion
 autocmd FileType java setlocal omnifunc=javacomplete#Complete
 autocmd FileType java JCEnable
 autocmd FileType java syntax match Comment +\/\/.\+$+
 nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
 imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
 nmap <F5> <Plug>(JavaComplete-Imports-Add)
 imap <F5> <Plug>(JavaComplete-Imports-Add)
 nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
 imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
 nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
 imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
 let g:javacomplete_java_compiler = 'javac'
 let g:JavaComplete_GradleExecutable = 'gradle'
