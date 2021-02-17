"adein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.vim/dein')
    call dein#begin('$HOME/.vim/dein')

    " Let dein manage dein
    " Required:
    call dein#add('$HOME/.vim/dein/repos/github.com/Shougo/dein.vim')

    call dein#add('itchyny/lightline.vim')
    call dein#add('mengelbrecht/lightline-bufferline')
    call dein#add('itchyny/vim-gitbranch')
    call dein#add('mbbill/undotree')
    call dein#add('tomtom/tcomment_vim')
    if executable('go')
        call dein#add('fatih/vim-go')
    endif
    call dein#add('scrooloose/nerdtree')
    call dein#add('Shougo/unite.vim')
    call dein#add('Shougo/neomru.vim')
    call dein#add('t9md/vim-quickhl')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('thinca/vim-visualstar')
    call dein#add('ConradIrwin/vim-bracketed-paste')
    call dein#add('junegunn/vim-peekaboo')
    call dein#add('google/vim-jsonnet')

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

"End dein Scripts-------------------------



"lightline--------------------------

if dein#tap('lightline.vim')
    let g:lightline#bufferline#show_number  = 1
    let g:lightline#bufferline#shorten_path = 0
    let g:lightline#bufferline#unnamed      = '[No Name]'
    let g:lightline = {
                \ 'colorscheme': 'landscape',
                \ 'active': {
                \   'left': [['mode', 'paste'],
                \            ['gitbranch','readonly', 'fullpath', 'modified']]
                \ },
                \ 'component_function': {
                \ },
                \ 'tabline': {
                \   'left': [['buffers']],
                \   'right': [['currenttab']]
                \ },
                \ 'component_expand': {
                \   'fullpath': 'LightlineFileNameWithFullPath',
                \   'cwd': 'getcwd',
                \   'gitbranch': 'gitbranch#name',
                \   'buffers': 'lightline#bufferline#buffers',
                \   'currenttab': 'LightlineCurrentTab',
                \ },
                \ 'component_type': {
                \   'buffers': 'tabsel'
                \ },
                \ }
endif

function! LightlineFileNameWithFullPath()
    if expand('%:t') ==# ''
        let filename = '[No Name]'
    else
        let filename = substitute(expand('%:p'), '^'.$HOME, "~", "")
    endif
    return filename
endfunction

function! LightlineCurrentTab()
  return '['.tabpagenr().'/'.tabpagenr('$').'] '.lightline#tab#filename(tabpagenr())
endfunction

"End lightline--------------------------

let g:go_version_warning = 0



" 表示設定---------------------------------------------------------------
syntax on	" コードの色分け
set title	" 編集中のファイル名を表示
set showmatch	" 括弧入力時の対応する括弧を表示
set ruler	" 右下にルーラーを表示する
set number	" 行番号を表示する
set cursorline  " 選択行をハイライト
set t_Co=256	" 256色使用
set visualbell t_vb=  "ビープ音を消す
set wildmenu
set wildmode=longest,list
set display=lastline
hi Comment ctermfg=lightblue

if dein#tap('vim-quickhl')
    vmap H <Plug>(quickhl-manual-this)
    nmap H <Plug>(quickhl-manual-reset)
endif

set smartindent	" オートインデント
set autoindent
set tabstop=4	" 見かけのタブ幅
set shiftwidth=4 " オートインデント幅
set softtabstop=0 " タブ幅
set expandtab  " タブをスペース複数個で表現
set cmdheight=1 " コマンドラインの高さ

"" 不可視文字を可視化
set list
set listchars=tab:»-  " タブ
set listchars+=trail:-  " 行末スペース
set listchars+=nbsp:%  " ノーブレークスペース
"set listchars+=eol:↲  " 改行
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:%

" ステータスライン
set laststatus=2 "ステータスラインを常に表示
"set statusline=%n:\  " ファイルナンバー
"set statusline+=%t " ファイル名表示
"set statusline+=%m " 読み込み専用かどうか
"set statusline+=%r " ヘルプページなら[HELP]と表示
"set statusline+=%h " プレビューウインドウなら[Preview]と表示
"set statusline+=%= " これ以降は右寄せ表示
"set statusline+=[%Y] " ファイルタイプ
"set statusline+=[ENC=%{&fileencoding}] " file encoding
"set statusline+=[LOW=%l/%L] "現在行数/全行数
set showcmd "入力中のコマンドを表示
set showtabline=2


" 検索設定---------------------------------------------------------------
set ignorecase	" 大文字/小文字の区別
set smartcase	" 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan	" 検索時に最後まで行ったら最初に戻る
set hlsearch " ハイライトサーチ
set incsearch  "インクリメンタルサーチ
nnoremap * *N
nnoremap # #N
map * <Plug>(visualstar-*)N
map # <Plug>(visualstar-#)N

" quickfix
autocmd QuickFixCmdPost *grep* cwindow
autocmd QuickFixCmdPost make* cwindow
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>


" 文字コード設定-----------------------------------------------------------
"set encoding=utf-8
"set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
"set fileformats=unix,dos,mac


" ディレクトリ設定-------------------------------------------------------
set autochdir " 編集中ファイルのディレクトリに移動

" バッファ
set hidden " バッファ移動時に保存警告を出さない
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


" キー設定---------------------------------------------------------------
set backspace=indent,eol,start
nnoremap <UP> gk
nnoremap <DOWN> gj
vnoremap <UP> gk
vnoremap <DOWN> gj
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
inoremap <C-@> <Nop>
nnoremap <silent> <ESC><ESC> :noh<CR>
nnoremap Y y$
nnoremap p ]p
nnoremap P ]P
nnoremap <S-h> 0
nnoremap <S-l> $
nnoremap <silent> <S-M> :s/^ \+//g<CR>:s/ \+/\r/g<CR>:noh<CR>
vnoremap <silent> <S-M> :s/^ \+//g<CR>:s/ \+/\r/g<CR>:noh<CR>

" persistent undo
if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
endif
if dein#tap('undotree')
    :command Undotree UndotreeShow
endif

