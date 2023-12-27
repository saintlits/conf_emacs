;; init-tex.el

;; 安装 AUCTeX（如果尚未安装）
(use-package auctex
  :ensure t
  :config
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-save-query nil
        TeX-PDF-mode t)  ;; 默认使用PDF模式
  :hook (LaTeX-mode . visual-line-mode))

;; 自动启用 AUCTeX for TeX files
(setq-default TeX-master nil)
(add-hook 'TeX-mode-hook 'turn-on-auto-fill)

;; 启用 reftex 支持（交叉引用、引用等）
(use-package reftex
  :ensure t
  :init
  (setq reftex-plug-into-AUCTeX t)
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-default-bibliography '("bibliography.bib"))
  (setq reftex-cite-format 'natbib))

;; 启用 Flyspell 拼写检查
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(provide 'init-tex)

