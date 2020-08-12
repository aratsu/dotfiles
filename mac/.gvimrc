" GUIオプション-------------------------------------------------------------
set guioptions-=m  " メニューバーを非表示
set guioptions-=T  " ツールバーを非表示 
set guioptions-=r  " 右スクロールバーを非表示
set guioptions-=R  " 右スクロールバーを非表示
set guioptions-=l  " 左スクロールバーを非表示
set guioptions-=L  " 左スクロールバーを非表示
set guioptions-=b  " 水平スクロールバーを非表示
set mouse=  " マウスを無効化
"set columns=95  " ウィンドウの幅
"set lines=30  " ウィンドウの高さ
"set guifont=Ubuntu\ Mono:h16
set guifont=Ubuntu\ Mono:h16
set nobackup  " バックアップファイルを作成しない
set noundofile  " undoファイルを作成しない


" カラースキーマ設定--------------------------------------------------------
colorscheme molokai  " sublime textテーマ
let g:molokai_original=1
let g:rehash256=1
set background=dark


" Golang
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

