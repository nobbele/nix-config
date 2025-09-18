(use-package nerd-icons
  :ensure t)

(use-package all-the-icons
  :ensure t)

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile))

(use-package treemacs
  :ensure t
  :demand t

  :config  
  (defun my/treemacs-save-workspace-silent ()
    "Save Treemacs workspace without confirmation."
    (let ((inhibit-message t))
      (ignore-errors (treemacs-save-workspace))))
  (add-hook 'kill-emacs-hook #'my/treemacs-save-workspace-silent)

  :bind
  (:map global-map
        ([f8]        . treemacs)
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)))

(provide 'init-treemacs)
