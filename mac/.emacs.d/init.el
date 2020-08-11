;;
;; ロードパスの設定
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)


;;
;; 環境を日本語、UTF-8にする
;;
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;;
;; フォント設定
;;
(create-fontset-from-ascii-font
  "Menlo-14:weight=normal:slant=normal"
  nil
  "menlokakugo")
(set-fontset-font
  "fontset-menlokakugo"
  'unicode
  (font-spec :family "Hiragino Kaku Gothic ProN")
  nil
  'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
(setq face-font-rescale-alist '(("Hiragino.*" . 1.2)))


;;
;; 表示設定
;;
;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)
;; 列数を表示する
(column-number-mode t)
;; 複数ウィンドウを禁止する
(setq ns-pop-up-frames nil)
;; メニューバーを消す
(menu-bar-mode 0)
;; ツールバーを消す
(tool-bar-mode 0)
;; タブにスペースを使用する
(setq-default tab-width 2 indent-tabs-mode nil)
;; 行数を表示する
(global-linum-mode t)
;; カーソルの点滅をやめる
(blink-cursor-mode 0)
;; カーソル行をハイライトする
(global-hl-line-mode t)
;; 対応する括弧を光らせる
(show-paren-mode 1)
;; スクロールは１行ごとに
(setq scroll-conservatively 1)
;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)
;; scratchの初期メッセージ消去
(setq initial-scratch-message "")
;; beep音の代わりに画面フラッシュ
;(setq visible-bell t)
;; beep音無効
(setq ring-bell-function 'ignore)


;;
;; キーバインド設定
;;
;; Macのoptionをメタキーにする
(setq mac-option-modifier 'meta) 
;; C-hでBackSpace
(global-set-key "\C-h" 'delete-backward-char)
;; C-kで行全体を削除する
;(setq kill-whole-line t)
;; ¥の代わりにバックスラッシュを入力する
(define-key global-map [?¥] [?\\])


;;
;; ファイル設定
;;
;; バックアップファイルを作成させない
(setq make-backup-files nil)
;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)


;;
;; undo-tree
;;
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)


;;
;; org-mode
;;
;; 画像をインラインで表示
(setq org-startup-with-inline-images t)
;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)
;; LOGBOOK drawerに時間を格納する
(setq org-clock-into-drawer t)
;; .orgファイルは自動的にorg-mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; ノートのファイル名
(setq org-default-notes-file "notes.org")
;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "NOW(n)" "|" "DONE(d)" "CANCELED(c)")))
;;  "すべてのサブタスクが終了するとDONEに切り替える"
(defun org-summary-todo (n-done n-not-done)
  (let (org-log-done org-log-states)   ; 記録「logging」を終了
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
;; DONEの時刻を記録
(setq org-log-done 'time)
;; ショートカットキー
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; org-directory内のファイルすべてからagendaを作成する
(setq org-directory "~/OneDrive/org/")
(setq org-agenda-files (list org-directory))
;; アジェンダ表示で下線を用いる
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)
;; 標準の祝日を利用しない
(setq calendar-holidays nil)
;; org-captureのテンプレート
(setq org-capture-templates
      '(("w" "Work" entry (file+headline "~/OneDrive/org/work2020.org" "Work")
         "* TODO %? %U\n%i\n%a")
        ("a" "Anime" entry (file+headline "~/OneDrive/org/private.org" "Anime")
         "* TODO %? %U\n%i\n%a")
        ("r" "Radio" entry (file+headline "~/OneDrive/org/private.org" "Radio")
         "* TODO %? %U\n%i\n%a")
        ("t" "Todo" entry (file+headline "~/OneDrive/org/todo.org" "Uncategorized Tasks")
         "* TODO %? %U\n%i\n%a")
        ("m" "Memo" entry (file+datetree "~/OneDrive/org/memo.org")
         "* %? %U\n%i\n%a")))
