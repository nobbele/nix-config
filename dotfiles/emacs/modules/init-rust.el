(use-package rust-mode
  :ensure t
  :hook (rust-mode . lsp) 
  :config
  (setq rust-format-on-save t))

(provide 'init-rust)
