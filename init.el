;; Remove GUI elements
(tool-bar-mode -1)             ; Hide the outdated icons
(scroll-bar-mode -1)           ; Hide the always-visible scrollbar
(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)      ; Ask for textual confirmation instead of GUI
(load   "~/.emacs.d/API_KEYS.el")

;; fix open window
;;(use-package emacs
;;	     :config
;;	     (set-frame-size (make-frame-size 150 50)))

;; 设置Emacs窗口大小
(add-to-list 'default-frame-alist '(width . 110))   ; 设置宽度为80列
(add-to-list 'default-frame-alist '(height . 45))  ; 设置高度为40行


;; Font
;  (set-face-attribute 'default nil 
;    ;; :font "PragmataPro Mono Liga" 
;    :font "Fira Code"
;    :height 118)
;; 最佳配置
;(set-face-attribute 'default nil :font (font-spec :family "Fira Code" :size 16))
;(set-fontset-font t 'unicode (font-spec :family "Noto Color Emoji" :size 14))
;(set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :font "三极行楷简体-粗" :size 16 :weight 'regular))
;; 完美搭配
(set-face-attribute 'default nil :font (font-spec :family "GoMono Nerd Font" :size 20))
(set-fontset-font t 'unicode (font-spec :family "Noto Color Emoji" :size 14))
(set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :font "三极行楷简体-粗" :size 18 :weight 'regular))
;(set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :font "xinyijixiangsong" :size 17 :weight 'regular))
;; 其他配置
;(set-face-attribute 'default nil :font (font-spec :family "IBM Plex Mono" :size 16))
;(set-fontset-font t 'unicode (font-spec :family "Noto Color Emoji" :size 14))
;(set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :font "三极行楷简体-粗" :size 16 :weight 'regular))

;; 换行
(global-visual-line-mode t)
;; 编码
;;(setq default-file-coding-systems '(utf-8 gb2312))
;(modify-coding-system-alist 'file "\\.txt\\'" 'chinese-gbk)
;(add-to-list 'auto-mode-alist '("\\.txt$" . 'chinese-gbk))






(set-language-environment "UTF-8")
;(set-default-coding-systems 'utf-8)
;(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
;(set-file-name-coding-system 'utf-8-unix)
;(set-keyboard-coding-system 'utf-8-unix)
(set-next-selection-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)



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
;; 安装Org模式
;;(use-package org
;;  :ensure t
;;  :hook (org-mode . auto-revert-mode))



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

;; enable clocking


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
;(use-package emacs
 ; :init
 ; (set-charset-priority 'unicode)
  ;(setq locale-coding-system 'utf-8
  ;      coding-system-for-read 'utf-8
  ;      coding-system-for-write 'utf-8)
  ;(set-terminal-coding-system 'utf-8)
  ;(set-keyboard-coding-system 'utf-8)
  ;(set-selection-coding-system 'utf-8)
  ;(prefer-coding-system 'utf-8)
  ;(setq default-process-coding-system '(utf-8-unix . utf-8-unix)))

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

;; 启用slime
;(use-package slime
;  :ensure t
;  :config
;  (setq inferior-lisp-program "sbcl"))


;; sly mode
(require 'sly-autoloads)
(setq inferior-lisp-program "/usr/bin/sbcl --dynamic-space-size 8Gb  ")
(add-hook 'lisp-mode-hook 'sly-editing-mode)

;; 使用LispWorks
;(ql:quickload "swank")
;(load "~/.emacs.d/elpa/slime-20xx/swank-loader.lisp")
;(load "/home/saint/.slime/fasl/2.28/sbcl-2.4.5-linux-x86-64/home/saint/.quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-quicklisp.fasl")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 插件库
;;
;; 设置Tex
(add-to-list 'load-path "~/.emacs.d/plugins")
(require 'init-tex)

;; 设置chinese-gbk
;(require 'chinese-gbk)


;; 打开一个Shell窗口
(defun open-shell ()
  "Open a shell window."
  (interactive)
  (split-window-below)  ; 在下方创建一个新窗口
  (other-window 1)      ; 切换到新窗口
  (setq eshell-banner-message "")
  (eshell)
  (other-window 1)      ; 切换回原窗口
  (enlarge-window 50))             ; 打开eshell

(global-set-key (kbd "C-c C-z") 'my-start-common-lisp-environment)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("774218d0781ca9aad07888de412eac35b7920bafc10ecc014ecf493d7a74b310" "b754d3a03c34cfba9ad7991380d26984ebd0761925773530e24d8dd8b6894738" "f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66" "4990532659bb6a285fee01ede3dfa1b1bdf302c5c3c8de9fad9b6bc63a9252f7" "6f1f6a1a3cff62cc860ad6e787151b9b8599f4471d40ed746ea2819fcd184e1a" "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69" "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19" "b30ab3b30e70f4350dad6bfe27366d573ace2190cc405c619bd5e602110c6e0c" "317b5f321d72b4ff9c465ceb343758c23b2a9465df33929accea63f414cedbaa" default))
 '(ignored-local-variable-values '((TeX-master . t)))
 '(org-agenda-files '("~/ywq_doc/journals/2024_03_16.org"))
 '(org-capture-templates
   '(("C-i" "Todo" entry
      (file+headline "/home/saint/ywq_doc/todo.txt/todo.txt" "Tasks")
      "* TODO %?\12  %i\12  %a" :prepend t :immediate-finish t :jump-to-captured t :empty-lines 1 :empty-lines-before 1 :clock-in t :clock-keep t :clock-resume t :time-prompt t :tree-type week))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )




;;;;;;;;;;;;;;;;;;;;;;;
;; 20231226 new plugins test
;; org-roam
;;(use-package org-roam
;;  :ensure t
;;  :init
;;  (org-roam-db-autosync-mode)
;;  (setq org-roam-completion-everywhere t)
;;  (setq org-roam-v2-ack t) ;; 如果你使用 v2 版本，请设置这个选项
;;  :custom
;;  (org-roam-directory "~/ywq_doc/")
;;  (org-roam-dailies-directory "journals/")
;;  (org-roam-capture-templates
;;   '(("d" "default" plain
;;      "%?" :target
;;      (file+head "pages/${slug}.org" "#+title: ${title}\n")
;;      :unnarrowed t)))
;;  :bind (("C-c n f" . org-roam-node-find)
;;         ("C-c n g" . org-roam-graph)
;;         ("C-c n i" . org-roam-node-insert)
;;         ("C-c n n" . org-roam-capture)
;;         ("C-c n t" . org-roam-dailies-capture-today)
;;         ("C-c n y" . org-roam-dailies-capture-yesterday)
;;         ("M-n" . org-id-get-create)
;;         ;; Add more keybindings as needed
;;         )
;;  :config
;;  (org-roam-setup))
;;;; org-roam new configure file load
(load "/home/saint/.emacs.d/plugins/org-roam.el")

;; org-roam-ui
(use-package org-roam-ui
  :ensure t     
  :defer t
  :straight
    (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
    :after org-roam
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :bind (("C-c n d" . org-roam-ui-mode))
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;;;;;;;;;;;
;; note search
;(use-package consult-notes
;  :straight (:type git :host github :repo "mclear-tools/consult-notes")
;  :commands (consult-notes
;             consult-notes-search-in-all-notes
;             ;; if using org-roam 
;             consult-notes-org-roam-find-node
;             consult-notes-org-roam-find-node-relation)
;  :config
;  (setq consult-notes-file-dir-sources '(("Org journals"  ?j  "/home/saint/ywq_doc/journals")
;					 ("Org pages"  ?p "/home/saint/ywq_doc/pages/"))) ;; Set notes dir(s), see below
;  ;; Set org-roam integration, denote integration, or org-heading integration e.g.:
;  (setq consult-notes-org-headings-files '("~/path/to/file1.org"
;                                           "~/path/to/file2.org"))
;  (consult-notes-org-headings-mode)
;  (when (locate-library "denote")
;    (consult-notes-denote-mode))
;  ;; search only for text files in denote dir
;  (setq consult-notes-denote-files-function (function denote-directory-text-only-files)))

;;;;;;
;; org-search
(use-package consult-org-roam
   :ensure t
   :after org-roam
   :init
   (require 'consult-org-roam)
   ;; Activate the minor mode
   (consult-org-roam-mode 1)
   :custom
   ;; Use `ripgrep' for searching with `consult-org-roam-search'
   (consult-org-roam-grep-func #'consult-ripgrep)
   ;; Configure a custom narrow key for `consult-buffer'
   (consult-org-roam-buffer-narrow-key ?r)
   ;; Display org-roam buffers right after non-org-roam buffers
   ;; in consult-buffer (and not down at the bottom)
   (consult-org-roam-buffer-after-buffers t)
   :config
   ;; Eventually suppress previewing for certain functions
   (consult-customize
    consult-org-roam-forward-links
    :preview-key "M-.")
   :bind
   ;; Define some convenient keybindings as an addition
   ("C-c n e" . consult-org-roam-file-find)
   ("C-c n b" . consult-org-roam-backlinks)
   ("C-c n B" . consult-org-roam-backlinks-recursive)
   ("C-c n l" . consult-org-roam-forward-links)
   ("C-c n r" . consult-org-roam-search))

;; org-bullets org美化插件
(use-package org-bullets
  :ensure t
  :config
  (setq org-bullets-bullet-list '("◉" "○" "●" "◎" "►" "▸"))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


;; multiple cursors
(use-package multiple-cursors
	     :ensure t
	     :init 
	     (global-set-key (kbd "C->") 'mc/mark-next-like-this)
	     (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
	     (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
	     (global-set-key (kbd "C-c m") 'mc/edit-lines)
	     :config
	     )

;; Org-sync 
;(add-to-list 'load-path "~/.emacs.d/plugins/org-sync")
;(mapc 'load
      ;;'("org-element" "os" "os-bb" "os-github" "os-rmine"))
;      '( "os" "os-bb" "os-github" "os-rmine"))

;; 配置 Deft 插件
(use-package deft
  :defer t
  :ensure t
  :bind (("C-c C-d" . deft))
  :config
  (setq deft-directory "~/ywq_doc")
  (setq deft-extensions '("txt" "md" "org"))
  (setq deft-use-filename-as-title t)
  (setq deft-auto-save-interval 0)
  (setq deft-default-extension "org")
  (setq deft-file-naming-rules
        '((noslash . "-")
          (nospace . "-")
          (case-fn . downcase))))

;; rust-emacs
;(require 'rust-mode)
(add-to-list 'load-path "/home/saint/code/rust/app/rust-mode")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
;; enable ruse autofomat
(setq rust-format-on-save t)
;; bind
(add-hook 'rust-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c C-m") 'rust-toggle-mutability)))

;; LSP
;;(add-hook 'rust-mode-hook #'lsp)
;; prettifying 
;(add-hook 'rust-mode-hook
;          (lambda () (prettify-symbols-mode)))
;; prettifying list 
;(push '(".add" . ?∔) rust-prettify-symbols-alist)



;; Funtional macro (not finish)
(defun org-roam-insert-node-in-all-files ()
  "Insert a Roam node in the current buffer, and every buffer of the active project's directory."
  (interactive)
  (let* ((project-directory ("/home/saint/ywq_doc/pages/"))
         (files (directory-files project-directory "t")))
    (dolist (file files)
      (with-current-buffer (find-file-noselect file)
        (org-id-get-create)
        (save-buffer)))))
;;;;;;;
;; use Helm
(require 'helm)
(helm-mode 1)

;;;;;;
;; use sketcher
(use-package sketch-mode
	     :defer t)

;;;;;; 
;; use mini-frame
;(use-package mini-frame
;	     :ensure t)




;; 自定义emacs主题
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
;(load-theme 'material t)
; (load-theme 'nord t)
;(load-theme 'afternoon t)
;(load-theme 'melancholy t)
(load-theme 'kanagawa t)
        (customize-set-variable 'timu-caribbean-scale-org-document-title 1.4)
        (customize-set-variable 'timu-caribbean-scale-org-document-info 1.4)
        (customize-set-variable 'timu-caribbean-scale-org-level-1 1.2)
        (customize-set-variable 'timu-caribbean-scale-org-level-2 1.1)
        (customize-set-variable 'timu-caribbean-scale-org-level-3 1)
        (customize-set-variable 'timu-spacegrey-org-intense-colors t)
        (customize-set-variable 'timu-spacegrey-muted-colors t)
        (customize-set-variable 'timu-spacegrey-contrasted-foreground t)
        (customize-set-variable 'timu-caribbean-mode-line-border nil)
	;(timu-line-mode 0)
;(load-theme 'timu-spacegrey t)

; (load-theme 'timu-caribbean t)

;;;;;;;
;; use nano pack
;(add-to-list 'load-path "/home/saint/.emacs.d/nano-emacs/")
;(require 'nano.el)
;(require 'nano-theme-dark.el)
;(require 'nano-splash.el)
;(require 'nano-command.el)
;;(use-package nano-emacs
;;  :demand
;;  :no-require t
;;  :straight (:host github :repo "rougier/nano-emacs")
;;  :defines (nano-font-family-monospaced nano-font-size)
;;  :bind ("C-M-z" . nano-toggle-theme)
;;  :config
;;  (setq nano-font-family-monospaced "Fira Code")
;;  (setq nano-font-size 14)
;;  (require 'nano))



;; 默认打开org-roam
(defun open-orgroam ()
  "Open a org window"
  (interactive)
  (org-roam-dailies-goto-today)
  (end-of-buffer))

;; 打开sly窗口
(defun my-start-common-lisp-environment ()
  "Start a Common Lisp environment in a new window."
  (interactive)
  ;(split-window-right)               ; 水平分割窗口
  ;(other-window 1)                   ; 切换到右侧窗口
  (sly))
  ;;(other-window 1)                   ; 切换回左侧窗口
  ;(inferior-lisp "sbcl"))


(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)


;; 在启动时打开Shell窗口
(add-hook 'emacs-startup-hook 'open-shell)
;;(add-hook 'emacs-startup-hook 'my-start-common-lisp-environment)

;; 在启动时检测是否打开了文件，如无则打开日志
(defun open-orgroam-if-scratch ()
  "Open org-roam if the current buffer is *scratch*."
  (when (equal (buffer-name) "*scratch*")
    (open-orgroam)))

(add-hook 'emacs-startup-hook 'open-orgroam-if-scratch)

;; auto snowEmacs
(defvar my-snow-timer nil)

(defun my-start-snow ()
   "Start snow if not already started."
  (unless (timerp my-snow-timer)
    (setq my-snow-timer (run-with-idle-timer 300 t 'snow))))

(defun my-stop-snow ()
   "Stop snow if running."
  (when (timerp my-snow-timer)
    (cancel-timer my-snow-timer)
    (setq my-snow-timer nil)
    (if (get-buffer "*snow*")
    (kill-buffer "*snow*")))
  (my-start-snow))

(defun my-check-idle-time ()
   "Check idle time and start/stop snow accordingly."
  (if (and (boundp 'last-input-event)
           (null (memq last-input-event '(nil undefined))))
      (my-stop-snow)
    (my-start-snow)))

(add-hook 'post-command-hook 'my-check-idle-time)

;; 所有txt使用gbk编码
(modify-coding-system-alist 'file "\\.txt\\'" 'gbk)

;;;; 循环调用代码高亮(unfinished)
;;(defun cycle-themes ()
;;  (interactive)
;;  (let ((theme-names (listify (themes-from-path theme-directory-list))))
;;    (let ((current-theme (cadr (assoc-default (current-theme-name nil)
;;                                          theme-names
;;                                          '())))
;;          (theme-name (next-element (nth 1 theme-names)
;;                                   (first theme-names))))
;;      (load-theme theme-name
;;                  'no-query
;;                  (concat "Enabled theme " theme-name))
;;      (message "Enabled theme %s" theme-name))))
;;
;;(global-set-key (kbd "C-+") 'cycle-themes)



;; 重设按键绑定

(global-set-key (kbd "M-j") 'org-roam-dailies-capture-today)
(global-set-key (kbd "M-n") 'org-roam-dailies-goto-next-note)
(global-set-key (kbd "M-p") 'org-roam-dailies-goto-previous-note)
(global-set-key (kbd "M-h") 'previous-buffer)
(global-set-key (kbd "M-l") 'next-buffer)

;;; 调整状态栏
;(setq mode-line-format
;      '("%e" mode-line-front-space
;        mode-line-mule-info mode-line-client mode-line-modified mode-line-remote
;        mode-line-frame-identification mode-line-buffer-identification "   "
;        mode-line-position
;        (vc-mode vc-mode) "  "
;        mode-line-modes mode-line-misc-info mode-line-end-spaces))
;
;(defun my-mode-line-icon ()
;  "Set a custom icon for the mode line."
;  (let ((icon (cond ((derived-mode-p 'lisp-mode) "λ")
;                    ((derived-mode-p 'emacs-lisp-mode) "EL")
;                    ;; 其他模式可以在这里添加
;                    (t ""))))
;    (setq mode-line-process icon)))
;
;(add-hook 'after-change-major-mode-hook 'my-mode-line-icon)

   (use-package all-the-icons
     :ensure t
     :config
     (setq all-the-icons-mode-icon-alist
           '(("lisp-mode" . (all-the-icons-faicon "code")))))

(insert (all-the-icons-icon-for-file "foo.js"))

;; env bound
(setenv "G" "/home/saint/code/shell/gpts.sh")
(setenv "g" "/home/saint/code/shell/gpts.sh")

;; 彩色lisp括号
     (use-package rainbow-delimiters
       :ensure t
       :hook ((emacs-lisp-mode lisp-mode lisp-interaction-mode) . rainbow-delimiters-mode))

;; 语法检查
     (use-package flycheck
       :ensure t
       :init (global-flycheck-mode))

;; 代码插入
     (use-package yasnippet
       :ensure t
       :config
       (yas-global-mode 1))
(require 'common-lisp-snippets)

;; 高亮括号
     (use-package highlight-parentheses
       :ensure t
       :hook ((emacs-lisp-mode lisp-mode lisp-interaction-mode) . highlight-parentheses-mode))

;; 自动右括号
  (require 'adjust-parens)
  (add-hook 'emacs-lisp-mode-hook #'adjust-parens-mode)
  (add-hook 'clojure-mode-hook #'adjust-parens-mode)
  (global-set-key (kbd "C-<return>") 'lisp-indent-adjust-parens)
  (global-set-key (kbd "M-<return>") 'lisp-dedent-adjust-parens)

;;; 智能匹配括号
 ;(package-install 'smartparens)
 (require 'smartparens-config)
 (smartparens-global-mode t)
 
 ;; 启用严格模式，这样你输入一个左括号时会自动补全右括号
 (setq sp-autoinsert-pair t)
 (setq sp-autodelete-pair t)
 
 ;; 启用严格删除模式，这样删除一个括号会自动删除匹配的括号
 (setq sp-autodelete-pair t)
 
 ;; 自动平衡括号
 (setq sp-autodelete-pair t)
 (setq sp-autoskip-closing-pair 'always)
 
 ;; 配置适用于 Emacs Lisp 模式的括号
 (sp-local-pair 'emacs-lisp-mode "(" ")" :actions '(insert wrap navigate))
 (sp-local-pair 'emacs-lisp-mode "[" "]" :actions '(insert wrap navigate))
 (sp-local-pair 'emacs-lisp-mode "{" "}" :actions '(insert wrap navigate))
 (sp-local-pair 'common-lisp-mode "(" ")" :actions '(insert wrap navigate))
 (sp-local-pair 'common-lisp-mode "[" "]" :actions '(insert wrap navigate))
 (sp-local-pair 'common-lisp-mode "{" "}" :actions '(insert wrap navigate))
 
 ;; 删除模式
 (define-key sp-keymap (kbd "C-d") 'sp-delete-char)
 (define-key sp-keymap (kbd "C-<backspace>") 'sp-backward-delete-char)
 
 ;; 自定义函数：在行首和行尾插入括号
 (defun insert-pair-at-line-start-and-end ()
   "Insert pair of parentheses at the beginning and end of the current line."
   (interactive)
   (save-excursion
     (beginning-of-line)
     (insert "(")
     (end-of-line)
     (insert ")")))
 
 ;; 自定义函数：在当前表达式的层级中插入括号
 (defun insert-pair-at-current-level ()
   "Insert pair of parentheses at the current expression level."
   (interactive)
   (let ((current-level (sp-get-enclosing-sexp)))
     (if current-level
         (progn
           (goto-char (sp-get current-level :beg))
           (insert "(")
           (goto-char (sp-get current-level :end))
           (insert ")"))
       (message "No enclosing expression found."))))

 ;; 自定义函数：在当前表达式的层级中删除括号
(defun delete-pair-at-current-level ()
  "Delete pair of parentheses at the current expression level."
  (interactive)
  (let ((current-level (sp-get-enclosing-sexp)))
    (if current-level
        (progn
          (goto-char (sp-get current-level :end))
          (delete-char -1)
          (goto-char (sp-get current-level :beg))
          (delete-char 1))
      (message "No enclosing expression found."))))


 ;; 自定义函数：在当前位置插入括号
 (defun insert-pair-at-position ()
  "Insert pair of parentheses at the current cursor position and at the end of the line."
  (interactive)
  (save-excursion
    (let ((line-end (line-end-position)))
      (insert "(")
      (goto-char line-end)
      (insert ")")))
  (forward-char 1))

 
 ;; 绑定自定义函数到快捷键
 (define-key sp-keymap (kbd "C-(") 'insert-pair-at-line-start-and-end)
 ;(define-key sp-keymap (kbd "C-M-(") 'insert-pair-at-current-level)
 (define-key sp-keymap (kbd "C-M-(") 'insert-pair-at-position)
 (define-key sp-keymap (kbd "S-<backspace>") 'delete-pair-at-current-level)
 
