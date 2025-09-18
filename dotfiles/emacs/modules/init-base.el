
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

(use-package psession
  :ensure t
  :hook (after-init . psession-mode))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(provide 'init-base)
