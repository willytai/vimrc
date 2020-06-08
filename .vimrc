set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'junegunn/fzf'
Plugin 'morhetz/gruvbox'
Plugin 'Dracula/vim'
Plugin 'altercation/vim-colors-solarized'
" colorscheme Dracula
" colorscheme solarized " this loos fucking weird
colorscheme gruvbox

Bundle 'Valloric/YouCompleteMe'
" ------------------------------YouCompleteMe configuration---------------------------
set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
"回车即选中当前项
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" 
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme 默认tab s-tab 和自动补全冲突
let g:ycm_key_list_select_completion = ['<enter>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_max_diagnostics_to_display = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0

nnoremap gl :YcmCompleter GoToDeclaration<CR>
nnoremap gf :YcmCompleter GoToDefinition<CR>
nnoremap gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <silent> fix :YcmCompleter<space>FixIt<CR>
nmap <F4> :YcmDiags<CR>

"force recomile with syntastic
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR> 
"nnoremap <leader>lo :lopen<CR> "open locationlist
"nnoremap <leader>lc :lclose<CR> "close locationlist
inoremap <leader><leader> <C-x><C-o>
" ------------------------------------------------------------------------------------

Bundle 'taglist.vim'
" -------------------------ctag plugin configuration----------------------------------
" ctrl + ] to jump to the definition part
" ctrl + t to go back
" :tn      next definition
" :tp      previous definition
let Tlist_Ctags_Cmd = 'ctags'
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_WinWidt = 30 "设置taglist的宽度
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
let Tlist_Use_Left_Windo = 1 "在左侧窗口中显示taglist窗口

function! UpdateCtags()
    silent !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q
    redraw!
    TlistUpdate
    echo "TAGS UPDATED!!"
endfunction

" open taglist and switch to its window
nnoremap tl :Tlist<CR><C-w>w
" update tags
command! Tupdate call<space>UpdateCtags()
" ------------------------------------------------------------------------------------

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" ------------------------------snippet configuration---------------------------------
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<c-b>"
" ------------------------------------------------------------------------------------

Plugin 'scrooloose/nerdtree'
"--------------------------------NERDTree configuration-------------------------------
" map <F2> :NERDTreeToggle<CR> " press F2 to hide or show NERDTree
let g:NERDTreeQuitOnOpen = 0
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd vimenter * NERDTree " auto open NERDTree when using vim
" ------------------------------------------------------------------------------------

Plugin 'terryma/vim-multiple-cursors'
" --------------------------multiple-cursors configuration----------------------------
" Ctrl-d for multi selection
" Ctrl-n for all matching selection
let g:multi_cursor_use_default_mapping = 0

let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<C-n>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<C-n>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
" ------------------------------------------------------------------------------------

Plugin 'tpope/vim-eunuch'

Plugin 'tpope/vim-surround'
" -------------------usage--------------------
" type cs"' to replace "" with '', vice versa
" ds" to remove ""
" ysiw" to add "" to one word
" --------------------------------------------

Bundle 'vim-fugitive'

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



syntax on
set nu " line number
set ru
set hlsearch " * key will highlight all occurrences of the word that is under the cursor
set incsearch
set smartindent
set confirm
set expandtab
set t_Co=256
set ai
set cursorline
set smarttab
set tabstop=4 " tab is 4 spaces wide
"set softtabstop=4 " count 4 spaces as tab
set shiftwidth=4
set mouse=a
set ic
set statusline=%4*%<\%m%<[%f\%r%h%w]\ [%{&ff},%{&fileencoding},%Y]%=\[Position=%l,%v,%p%%]
set fileencodings=utf-8,cp950,big5,gbk,latin1
"set encoding=big5
set autoread
au CursorHold * checktime
set copyindent
set wrap
set linebreak

set title " change the terminal's title
set laststatus=2 " always show status line

" display tab and trail spaces
set list
set listchars=tab:⋅⋅,trail:⋅,nbsp:⋅

set backspace=2 " make backspace work like most other apps
set backspace=indent,eol,start " backspace fix
set background=dark
filetype indent on

inoremap {<CR> {<CR>}<Esc>ko
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>
nnoremap <space>1 1gt
nnoremap <space>2 2gt
nnoremap <space>3 3gt
nnoremap <space>4 4gt
nnoremap <space>5 5gt
nnoremap <space>6 6gt
nnoremap <space>7 7gt
nnoremap <space>8 8gt
nnoremap <space>9 9gt
nnoremap gb gT
nnoremap <space>w <C-w>w
nnoremap <silent> ,<space> :nohlsearch<CR>
command! Reloadall tabdo<space>e
command! Closeall tabdo<space>q

au BufReadPost *.gp set syntax=gnuplot " enable gnuplot syntax with files that ends with .gp
