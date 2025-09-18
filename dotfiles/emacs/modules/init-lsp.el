(use-package lsp-mode
  :ensure t
  :commands lsp

  :hook (lsp-mode . lsp-enable-which-key-integration)

  :config
  (setq lsp-prefer-flymake nil))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :after lsp-mode
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-doc-enable t))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1)
        
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<return>") nil))

(provide 'init-lsp)
