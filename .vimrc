colorscheme torte

"" group all generated files
if !isdirectory(expand("$HOME/.vimundo"))
  call mkdir(expand("$HOME/.vimundo"))
endif
if !isdirectory(expand("$HOME/.vimbackup"))
  call mkdir(expand("$HOME/.vimbackup"))
endif
set undodir=~/.vimundo,.,/tmp
set backupdir=~/.vimbackup,.,/tmp
set directory=.,~/tmp,/var/tmp,/tmp

"" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
if !&diff && !isdirectory("./vendor/laravel") " excluding Laravel projects
  augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :Vexplore
  augroup END
endif

"" vim-plug
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'
Plug 'Yggdroot/indentLine'
Plug 'pangloss/vim-javascript'        "| js
Plug 'w0rp/ale'                       "| async lint
Plug 'tpope/vim-dispatch'             "|
Plug 'tpope/vim-projectionist'        "|
Plug 'tpope/vim-surround'             "| (())
Plug 'noahfrederick/vim-composer'     "|
Plug 'noahfrederick/vim-laravel'
Plug 'tomlion/vim-solidity'           "| solidity
Plug 'christoomey/vim-tmux-navigator'
Plug 'StanAngeloff/php.vim'           "| php folding
Plug 'rayburgemeestre/phpfolding.vim' "| php folding
Plug 'benmills/vimux'                 "| tmux
Plug 'wlangstroth/vim-racket'         "| racket
Plug 'kien/rainbow_parentheses.vim'   "| racket
Plug 'hiphish/info.vim'               "| Read info files
Plug 'chrisbra/Colorizer'             "| ANSI colours
Plug 'drmingdrmer/vim-toggle-quickfix'
Plug 'ekalinin/Dockerfile.vim'        "| docker
Plug 'jiangmiao/auto-pairs'
Plug 'simeji/winresizer'
Plug 'osyo-manga/vim-over'            "| preview search pattern over command line
Plug 'neovimhaskell/haskell-vim'
Plug 'itchyny/vim-haskell-indent'
Plug 'nbouscal/vim-stylish-haskell'
call plug#end()

"" w0rp/ale: If encounting problems, debug with :ALEInfo command
let g:ale_enabled = 0
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'php': ['php', 'phpcs'],
\   'solidity': ['solium'],
\}

set hlsearch    "| http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
set incsearch   "| http://vim.wikia.com/wiki/Searching#Show_the_next_match_while_entering_a_search
set splitbelow
set splitright

if has("win32unix")
"" vim/cygwin block cursor
"  let &t_ti.="\e[1 q"
"  let &t_SI.="\e[5 q"
"  let &t_EI.="\e[1 q"
"  let &t_te.="\e[0 q"
"" tmux-navigator workaround
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>
endif

"" vim <C-right> bindings
set term=xterm-256color

"" SCHEME/RACKET
set lispwords-=if "| DrRacket's if-indent style
set lispwords+=λ
set lispwords+=let/cc
au BufReadPost,BufNewFile *.rkt let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'}, ['''', '`'])

"" vimdiff
au BufEnter,BufNew * if &diff | syntax off | else | syntax on | endif
filetype plugin indent on

"" close quickfix window
nmap <F2> <Plug>window:quickfix:toggle
nnoremap <F3> <Esc>:w<CR>:Dispatch racket %<CR>

"" fix netrw C-L mapping
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
    noremap <buffer> <C-L> :TmuxNavigateRight<CR>
endfunction

"" vim-over
nnoremap <leader>s :OverCommandLine<CR> %s/<C-r><C-w>
