colorscheme torte

"" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

"" vim-plug
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'
Plug 'Yggdroot/indentLine'
Plug 'pangloss/vim-javascript'        "| js
Plug 'tpope/vim-dispatch'             "| Laravel
Plug 'tpope/vim-projectionist'        "|
Plug 'noahfrederick/vim-composer'     "|
Plug 'noahfrederick/vim-laravel'
Plug 'tomlion/vim-solidity'           "| Solidity
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

set hlsearch    "| http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
set incsearch   "| http://vim.wikia.com/wiki/Searching#Show_the_next_match_while_entering_a_search
set splitbelow
set splitright

"" vim/cygwin block cursor
if has("win32unix")
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

"" vim <C-right> bindings
set term=xterm-256color
