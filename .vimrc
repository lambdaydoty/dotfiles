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
Plug 'tpope/vim-dispatch'             "| laravel
Plug 'tpope/vim-projectionist'        "|
Plug 'noahfrederick/vim-composer'     "|
Plug 'noahfrederick/vim-laravel'
Plug 'tomlion/vim-solidity'           "| solidity
Plug 'christoomey/vim-tmux-navigator'
Plug 'StanAngeloff/php.vim'           "| php folding
Plug 'rayburgemeestre/phpfolding.vim' "| php folding
Plug 'benmills/vimux'                 "| tmux
Plug 'wlangstroth/vim-racket'         "| racket
Plug 'kien/rainbow_parentheses.vim'   "| racket
call plug#end()

set hlsearch    "| http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
set incsearch   "| http://vim.wikia.com/wiki/Searching#Show_the_next_match_while_entering_a_search
set splitbelow
set splitright

"" vim/cygwin block cursor
"if has("win32unix")
"  let &t_ti.="\e[1 q"
"  let &t_SI.="\e[5 q"
"  let &t_EI.="\e[1 q"
"  let &t_te.="\e[0 q"
"endif

"" vim <C-right> bindings
set term=xterm-256color

"" vim drracket's if-indent style
set lispwords-=if

"" options for 'kien/rainbow_parentheses.vim'
" let g:rbpt_colorpairs = [
"     \ ['brown',       'RoyalBlue3'],
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkgray',    'DarkOrchid3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['brown',       'firebrick3'],
"     \ ['gray',        'RoyalBlue3'],
"     \ ['black',       'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
"     \ ['darkred',     'DarkOrchid3'],
"     \ ['red',         'firebrick3'],
"     \ ]
" let g:rbpt_max = 16
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
