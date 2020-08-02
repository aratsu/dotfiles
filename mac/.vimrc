"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('$HOME/.vim/dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('scrooloose/nerdtree')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('Shougo/neocomplete.vim')
call dein#add('tomasr/molokai')
call dein#add('tpope/vim-endwise')
call dein#add('tomtom/tcomment_vim')
"call dein#add('nathanaelkane/vim-indent-guides')
"call dein#add('bronson/vim-trailing-whitespace')
"call dein#add('kana/vim-smartinput')
"call dein#add('cohama/vim-smartinput-endwise')
call dein#add('itchyny/lightline.vim')
call dein#add('tpope/vim-fugitive')
"call dein#add('airblade/vim-gitgutter')


" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------



" NeoComplete--------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" End NeoComplete--------------------



" lightline-------------------------
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|'}
      \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" End lightline---------------------



"" SmartInput-------------------------
"call smartinput_endwise#define_default_rules()
"call smartinput#map_to_trigger('i', '<BS>', '<BS>', '<BS>')
"call smartinput#map_to_trigger('i', '<CR>', '<CR>', '<CR>')
"call smartinput#define_rule({
"            \   'at'    : '()\%#',
"            \   'char'  : '<BS>',
"            \   'input' : '<BS>',
"            \   })
"call smartinput#define_rule({
"            \   'at'    : '""\%#',
"            \   'char'  : '<BS>',
"            \   'input' : '<BS>',
"            \   })
"call smartinput#define_rule({
"            \   'at'    : '{}\%#',
"            \   'char'  : '<BS>',
"            \   'input' : '<BS>',
"            \   })
"call smartinput#define_rule({
"            \   'at'    : '[]\%#',
"            \   'char'  : '<BS>',
"            \   'input' : '<BS>',
"            \   })
"call smartinput#define_rule({
"            \   'at'    : '\''\''\%#',
"            \   'char'  : '<BS>',
"            \   'input' : '<BS>',
"            \   })
"call smartinput#define_rule({
"            \   'at'    : '""""""\%#',
"            \   'char'  : '<BS>',
"            \   'input' : '<BS><BS><BS>',
"            \   })
"" End SmartInput---------------------





" 表示設定---------------------------------------------------------------
set title	" 編集中のファイル名を表示
set showmatch	" 括弧入力時の対応する括弧を表示
syntax on	" コードの色分け
set ruler	" 右下にルーラーを表示する
set number	" 行番号を表示する
set t_Co=256	" 256色使用
set visualbell t_vb=  "ビープ音を消す
set wildmenu
set wildmode=longest
set display=lastline

set smartindent	" オートインデント
set autoindent
set tabstop=4	" 見かけのタブ幅
set shiftwidth=4 " オートインデント幅
set softtabstop=0 " タブ幅
set expandtab  " タブをスペース複数個で表現
set cmdheight=1 " コマンドラインの高さ

"" 不可視文字を可視化
"set list
"set listchars=tab:»-  " タブ
"set listchars+=trail:-  " 行末スペース
"set listchars+=nbsp:%  " ノーブレークスペース
"set listchars+=eol:¬  " 改行

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


" 検索設定---------------------------------------------------------------
set ignorecase	" 大文字/小文字の区別
set smartcase	" 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan	" 検索時に最後まで行ったら最初に戻る
set hlsearch " ハイライトサーチ
set incsearch  "インクリメンタルサーチ

" quickfix
autocmd QuickFixCmdPost *grep* cwindow
autocmd QuickFixCmdPost make* cwindow
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>


"" 文字コード設定-----------------------------------------------------------
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
nnoremap <Esc><Esc> :noh<CR>
