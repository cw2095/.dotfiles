"        _                     "
" __   _(_)_ __ ___  _ __ ___  "
" \ \ / / | '_ ` _ \| '__/ __| "
"  \ V /| | | | | | | | | (__  "
" (_)_/ |_|_| |_| |_|_|  \___| "
"                              "
" leader
let mapleader=" "
let g:mapleader = ' '

" 基本配置
if &compatible
    " 不要兼容vi
    set nocompatible
endif
set shortmess+=c
" 文件在外部被修改过，重新读入
set autoread
" 自动写回
set autowrite
" 显示确认对话框
set confirm
set history=1000
set winaltkeys=no
set ttyfast
set lazyredraw
" 更新时间100ms 默认4000ms 写入swap的时间
set updatetime=100
" 光标
set guicursor=n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20

" syntax
if has('syntax')
    syntax enable
    syntax on
endif

" filetype
if has('autocmd')
    filetype plugin indent on
endif

if has('multi_byte')
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
endif
" 文件换行符，默认使用unix换行符
set fileformats=unix,dos,mac
set formatoptions-=tc
set formatoptions+=mB

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set t_vb=
set tm=500

set noswapfile
set nobackup
set nowritebackup

" 搜索高亮
set incsearch
" 高亮匹配内容
set hlsearch
" 搜索高亮颜色
hi Search ctermfg=17 ctermbg=190 guifg=#000000 guibg=#ffff00
set ignorecase
set smartcase
" Adjust case in insert completion mode
set infercase

set list
" 只有set list下面的才会起作用
if &list
    set listchars=tab:\|\→·,nbsp:⣿,extends:»,precedes:«
    set listchars+=eol:¬
    set listchars+=trail:·
    " set listchars+=space:␣
endif

" tab
set expandtab
set smarttab
set shiftround

" indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent
set indentexpr=

" fold
if has('folding')
    set foldenable
    " 基于缩进的折叠
    set foldmethod=indent
    " 默认打开所有缩进
    set foldlevel=99
endif
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,noinsert,menuone,noselect,preview
set wildmenu
set wildmode=longest,list,full

" Make backspace work as you would expect.
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

set notimeout
set ttimeout
" set timeoutlen=500
set ttimeoutlen=0

" 允许使用鼠标, normal生效，a则是全模式生效
set mouse=n
" 与系统共用剪切板
" 在某些系统上可能会出现vim打开时间长的问题
set clipboard=unnamedplus

set virtualedit=block
" set autochdir

" show
set t_ut=
set t_Co=256
set termguicolors

set cursorline
set colorcolumn=80
set cursorlineopt=number
set signcolumn=yes

set exrc
set secure
set list
set ruler
set title
set number
set relativenumber
set showmode
set showcmd
set showmatch
set matchtime=2
set display=lastline
set scrolloff=4
set wrap
" 软折行
set linebreak
set textwidth=0
" Always report changed lines.
set report=0
" 终端隐藏后不结束
set hidden

set splitright
set splitbelow

set viewoptions=cursor,folds,slash,unix
set sessionoptions+=globals



" 定位到退出位置并移动到屏幕中央
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz
    " Auto change directory to current dir
    autocmd BufEnter * silent! lcd %:p:h
endif

" let g:neoterm_autoscroll = 1
" autocmd TermOpen term://* startinsert

" ============================ theme and status line ============================

" theme
set background=dark
colorscheme desert

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the status line - use 2 lines for the status bar
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%{&ff}][%p%%]

" ============================ specific file type ===========================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd

autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc

autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" ============================ key map ============================

au InsertLeave * set nopaste

" select all
map <Leader>sa ggVG"

" save
cmap w!! w !sudo tee >/dev/null %

" Set <LEADER> as <SPACE>, ; as :
nmap Q <nop>
nmap q <nop>
nnoremap <M-q> q

nnoremap gp :set paste<CR>
nnoremap gP :set nopaste<CR>

noremap ; :
nnoremap ! :!

noremap - N
noremap = n

" Save & quit
nnoremap  <LEADER>s <esc>:w<cr>
nnoremap Q <esc>:close<cr>
vnoremap Q <esc>:close<cr>

" make Y to copy till the end of the line
nnoremap Y y$
nnoremap vv ^vg_
nnoremap \v v$h

" Copy to system clipboard
vnoremap Y "+y

" Indentation
nnoremap < <<
nnoremap > >>

" 关闭搜索颜色
nnoremap <BackSpace> :nohl<cr>

" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Space to Tab
nnoremap <LEADER>ff :%s/    /\t/g
vnoremap <LEADER>ff :s/    /\t/g
nnoremap <LEADER>ft :%s/\t/    /g
vnoremap <LEADER>ft :s/\t/    /g

" Folding
noremap <silent> <LEADER>o za

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
noremap <silent> K 5k
noremap <silent> J 5j

noremap <C-U> 5<C-y>
noremap <C-E> 5<C-e>

" Insert Mode Cursor Movement
inoremap <C-a> <ESC>A
inoremap <M-o> <esc>o
inoremap <M-O> <esc>O
" inoremap <M-h> <HOME>
inoremap <M-h> <esc>^i
inoremap <M-l> <END>
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap jk <esc>

" Command Mode Cursor Movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>

"  Window management
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l

" Disable the default s key
noremap s <nop>
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<cr>:split<cr>:set splitbelow<cr>
noremap sj :set splitbelow<cr>:split<cr>
noremap sh :set nosplitright<cr>:vsplit<cr>:set splitright<cr>
noremap sl :set splitright<cr>:vsplit<cr>

" Resize splits with arrow keys
noremap s<up> :res +5<cr>
noremap s<down> :res -5<cr>
noremap s<left> :vertical resize-5<cr>
noremap s<right> :vertical resize+5<cr>

" Press <SPACE> + q to close the window below the current window
nnoremap <LEADER>q <C-w>j:q<cr>

" window
" nnoremap <leader>w- <C-w>s
" nnoremap <leader>w/ <C-w>v
" nnoremap <leader>ww <C-w>w
" nnoremap <leader>wW <C-w>W
" nnoremap <leader>0  <C-w>t
" nnoremap <leader>1  <C-w>t<C-w>w
" nnoremap <leader>2  <C-w>t<C-w>w<C-w>w
" nnoremap <leader>3  <C-w>t<C-w>w<C-w>w<C-w>w
" nnoremap <leader>4  <C-w>t<C-w>w<C-w>w<C-w>w<C-w>w
" nnoremap <leader>5  <C-w>t<C-w>w<C-w>w<C-w>w<C-w>w<C-w>w
" nnoremap <leader>w= <C-w>=
" nnoremap <leader>w< <C-w><
" nnoremap <leader>w> <C-w>>
" nnoremap <leader>wd <C-w>c

" Tab management
nnoremap <silent> tn :tabnew<cr>
nnoremap <silent> tc :tabclose<cr>
nnoremap <silent> th :-tabnext<cr>
nnoremap <silent> tl :+tabnext<cr>¬
nnoremap <silent> tmh :-tabmove<cr>
nnoremap <silent> tml :+tabmove<cr>¬

" buffer
" nnoremap <leader>b :<C-u>b
" nnoremap <leader>bb :<C-u>ls<CR>
" nnoremap <leader>bp :<C-u>bp<CR>
" nnoremap <leader>bn :<C-u>bn<CR>
" nnoremap <leader>bd :<C-u>bd<CR>

" find and replace
nnoremap \s :%s//g<left><left>
nnoremap \s :<C-u>%s///g<Left><Left><Left>
vnoremap \s :s///g<Left><Left><Left>

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" Call figlet
nnoremap tx :r !figlet<space><space><space><space>

nnoremap \p :echo expand('%:p')<CR>

"file explorer
nnoremap <leader>ff :<C-u>E<CR>
nnoremap <leader>f- :<C-u>Se<CR>
nnoremap <leader>f/ :<C-u>Ve<CR>

" 以下内容来自韦大的配置
" 文件搜索和补全时忽略下面的扩展名
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
"stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
" MacOSX/Linux
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android

