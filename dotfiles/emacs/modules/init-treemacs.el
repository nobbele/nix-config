

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile)

  :config
  (setq projectile-switch-project-action
      #'treemacs-display-current-project-exclusively))

(use-package treemacs
  :ensure t
  :config  
  (defun my/treemacs-save-workspace-silent ()
    "Save Treemacs workspace without confirmation."
    (let ((inhibit-message t))
      (ignore-errors (treemacs-save-workspace))))
  (add-hook 'kill-emacs-hook #'my/treemacs-save-workspace-silent)
  (treemacs-project-follow-mode t)

  :bind
  (:map global-map
        ([f8]        . treemacs)
        ("C-x t B"   . treemacs-bookmark)))

(provide 'init-treemacs)
