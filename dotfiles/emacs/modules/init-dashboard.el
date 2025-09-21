(use-package dashboard
  :ensure t
  :init
  (dashboard-setup-startup-hook)

  :config
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-startup-banner (expand-file-name "~/.config/emacs/gay_emacs.png"))
  (setq dashboard-image-banner-max-height 150)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (bookmarks . 5)))
  (setq dashboard-banner-logo-title "Welcome to Emacs!"))

(defvar my/dashboard-file-opened nil
  "Flag to track if a file has been opened from the Dashboard.")

(defun my/dashboard-file-opened-trigger ()
  "Open Treemacs for the Projectile project after opening a file from Dashboard."
  ;; Only trigger if not yet triggered, file is in a project, and previous buffer was Dashboard
  (when (and (not my/dashboard-file-opened)
             (projectile-project-p)
             (get-buffer "*dashboard*"))
    ;; Defer execution so file opens normally first
    (run-at-time
     0 nil
     (lambda ()
       (setq my/dashboard-file-opened t)
       (treemacs-add-and-display-current-project)))))

;; Run after opening any file
(add-hook 'find-file-hook #'my/dashboard-file-opened-trigger)

(provide 'init-dashboard)
