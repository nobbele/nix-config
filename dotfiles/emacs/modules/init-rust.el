(use-package rust-mode
  :hook (rust-mode . lsp) 
  :config
  (setq rust-format-on-save t))

(provide 'init-rust)
