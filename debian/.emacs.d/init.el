;; ロードパスの設定

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)
;
;(setq load-path (append
;                 '("~/.emacs.d/packages")
;                 load-path))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; Fonts
(let* ((size 15)
       (asciifont "Ricty")
       (jpfont "Ricty")
       (h (* size 10))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec)
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))

;; mozc
(require 'mozc)
(setq default-input-method "japanese-mozc")
(global-set-key (kbd "C-SPC") 'toggle-input-method)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; バックアップファイルを作成させない
(setq make-backup-files nil)

;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;; 改行コードを表示する
;(setq eol-mnemonic-dos "(CRLF)")
;(setq eol-mnemonic-mac "(CR)")
;(setq eol-mnemonic-unix "(LF)")

;; 複数ウィンドウを禁止する
(setq ns-pop-up-frames nil)

;; ウィンドウを透明にする
;; アクティブウィンドウ／非アクティブウィンドウ（alphaの値で透明度を指定）
;(add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))

;; メニューバーを消す
(menu-bar-mode -1)
;; ツールバーを消す
(tool-bar-mode -1)

;; 列数を表示する
(column-number-mode t)
;; 行数を表示する
(global-linum-mode t)
(if (not window-system) (progn
    (setq linum-format "%3d|")
))
(if window-system (progn
    (setq linum-format "%3d")
))

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; カーソル行をハイライトしない
(global-hl-line-mode 0)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; ウィンドウ内に収まらないときだけ、カッコ内も光らせる
;(setq show-paren-style 'mixed)
;(set-face-background 'show-paren-match-face "grey")
;(set-face-foreground 'show-paren-match-face "black")

;; スペース、タブなどを可視化する
(require 'whitespace)
;(setq whitespace-style
;    '(
;      face ; faceで可視化
;      space-mark ; 表示のマッピング
;      tab-mark
;      )
;)
(global-whitespace-mode 0)

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; シフト＋矢印で範囲選択
;(setq pc-select-selection-keys-only t)
;(pc-selection-mode)

;; C-kで行全体を削除する
(setq kill-whole-line t)

;;; dired設定
(require 'dired-x)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;; マウス無効化
(global-unset-key [mouse-1])
(global-unset-key [down-mouse-1])
(global-unset-key [drag-mouse-1])
(global-unset-key [double-mouse-1])
(global-unset-key [double-drag-Mouse-1])
(global-unset-key [triple-mouse-1])
(global-unset-key [triple-drag-mouse-1])
(global-unset-key [\S-down-mouse-1])
(global-unset-key [\C-down-mouse-1])
(global-unset-key [\M-mouse-1])
(global-unset-key [\M-down-mouse-1])
(global-unset-key [\M-drag-mouse-1])
(global-unset-key [mouse-2])
(global-unset-key [mouse-3])
(global-unset-key [\S-mouse-3])
(global-unset-key [\S-down-mouse-3])
(global-unset-key [\C-down-mouse-3])
(global-unset-key [\M-mouse-3])

;; beep音を消す
;(defun my-bell-function ()
;  (unless (memq this-command
;        '(isearch-abort abort-recursive-edit exit-minibuffer
;              keyboard-quit mwheel-scroll down up next-line previous-line
;              backward-char forward-char))
;    (ding)))
;(setq ring-bell-function 'my-bell-function)
(setq ring-bell-function 'ignore)

;; C言語
(add-hook 'c-mode-common-hook
    (lambda ()
        (c-set-style "bsd")
        (setq c-basic-offset 4)
        ;; 演算式が複数行にまたがるときのオフセット
        (c-set-offset 'statement-cont 'c-lineup-math)
        ;; 行末のスペースやタブに色づけして警告する。
        ;(setq show-trailing-whitespace t)
    )
)

;; クリップボード
(setq x-select-enable-clipboard t)

;; Back Space
(global-set-key "\C-h" 'delete-backward-char)

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; markdown-preview-mode
(setq markdown-preview-stylesheets
      (list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (uuidgen markdown-mode+ markdown-preview-mode ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

