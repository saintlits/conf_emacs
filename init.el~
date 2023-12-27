;; Remove GUI elements
(tool-bar-mode -1)             ; Hide the outdated icons
(scroll-bar-mode -1)           ; Hide the always-visible scrollbar
(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)      ; Ask for textual confirmation instead of GUI

;; fix open window
;;(use-package emacs
;;	     :config
;;	     (set-frame-size (make-frame-size 150 50)))

;; 设置Emacs窗口大小
(add-to-list 'default-frame-alist '(width . 85))   ; 设置宽度为80列
(add-to-list 'default-frame-alist '(height . 40))  ; 设置高度为40行

;; 打开一个Shell窗口
(defun open-shell ()
  "Open a shell window."
  (interactive)
  (split-window-below)  ; 在下方创建一个新窗口
  (other-window 1)      ; 切换到新窗口
  (eshell)
  (enlarge-window -10))             ; 打开eshell

;; 定义史莱姆
(defun my-start-common-lisp-environment ()
  "Start a Common Lisp environment in a new window."
  (interactive)
  (split-window-right)               ; 水平分割窗口
  (other-window 1)                   ; 切换到右侧窗口
  (eshell)                           ; 打开 Shell 窗口
  (other-window 1)                   ; 切换回左侧窗口
  (inferior-lisp "allegro"))
  ;(run-lisp "allegro"))                           ; 启动 SLIME

(global-set-key (kbd "C-c C-z") 'my-start-common-lisp-environment)


;; 在启动时打开Shell窗口
(add-hook 'emacs-startup-hook 'open-shell)

;; 启用'use-package'库
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; 安装Markdown模式
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :hook (markdown-mode . auto-revert-mode))


;; 启用重载
(global-auto-revert-mode 1)
(setq auto-revert-check-vc-info t) ; 同时检查版本控制信息
(add-hook 'markdown-mode-hook 'auto-revert-mode)

;; Set up straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
    (expand-file-name
      "straight/repos/straight.el/bootstrap.el"
      (or (bound-and-true-p straight-base-dir)
        user-emacs-directory)))
    (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
       'silent 'inhibit-cookies)
    (goto-char (point-max))
    (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package
(straight-use-package 'use-package)

;; Make use-package use straight.el
(setq straight-use-package-by-default t)

;; Always :defer t
(setq use-package-always-defer t)

;; Remove initial scratch message and "For information about GNU Emacs and the 
;; GNU system, type C-h C-a"
(use-package emacs
  :init
  (setq initial-scratch-message nil)
  (defun display-startup-echo-area-message ()
    (message "")))

;; Allow y/n instead of having to type yes/no
(use-package emacs
  :init
  (defalias 'yes-or-no-p 'y-or-n-p))

;; UTF-8 everywhere
(use-package emacs
  :init
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix)))

;; Use spaces by default, and set tab width to 2
(use-package emacs
  :init
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))

;; Set up keybindings on macOS
(use-package emacs
  :init
	(when (eq system-type 'darwin)
		(setq mac-command-modifier 'super)
		(setq mac-option-modifier 'meta)
		(setq mac-control-modifier 'control)))

;; Vim keybindings
(use-package evil
  :demand ; No lazy loading
  :config
  (evil-mode 1))

;; Font
(use-package emacs
  :init
  (set-face-attribute 'default nil 
   ;; :font "PragmataPro Mono Liga" 
    :height 150))

;; Theme
(use-package doom-themes
  :demand
  :config
  (load-theme 'doom-challenger-deep t))

;; Relative line numbers
(use-package emacs
  :init
  (defun ab/enable-line-numbers ()
    "Enable relative line numbers"
    (interactive)
    (display-line-numbers-mode)
    (setq display-line-numbers 'relative))
  (add-hook 'prog-mode-hook #'ab/enable-line-numbers))

;; Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Nerd icons (used by doom-modeline)
(use-package nerd-icons)

;; Nyan Mode in the modeline
(use-package nyan-mode
  :init
  (setq nyan-minimum-window-width 0)
  (setq nyan-animate-nyancat t)
  (setq nyan-animation-frame-interval 0.3)
  (setq nyan-wavy-trail t)
  (nyan-mode))
