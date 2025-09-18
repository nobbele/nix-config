(use-package doom-themes
  :ensure t
  
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-theme 'doom-colors)

  :config
  (load-theme 'doom-dark+ t)

  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(provide 'init-theme)