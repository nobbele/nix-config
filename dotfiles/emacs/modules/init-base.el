
(setq inhibit-startup-message t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)

(cua-mode t)
(setq cua-auto-tabify-rectangles nil)
(setq cua-keep-region-after-copy t)
(transient-mark-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(use-package all-the-icons
  :ensure t)

(require 'init-storm)
(require 'init-theme)
(require 'init-treemacs)
(require 'init-lsp)
(require 'init-rust)
(require 'init-term)

(use-package psession
  :ensure t
  :hook (after-init . psession-mode))
  
(provide 'init-base)
