
(setq inhibit-startup-message t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(setq cursor-type 'bar)

(cua-mode t)
(setq cua-auto-tabify-rectangles nil)
(setq cua-keep-region-after-copy t)
(transient-mark-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(use-package emacs
  :bind
  ("C-k" . kill-whole-line))

(use-package nerd-icons
  :ensure t)
(require 'vc-git)

(require 'init-storm)
(require 'init-theme)
(require 'init-treemacs)
(require 'init-lsp)
(require 'init-rust)
(require 'init-term)
(require 'init-lang)
(require 'init-dashboard)

(use-package projectile
  :ensure t
  :demand t
  :init
  (setq projectile-project-search-path '("~/Projects/"))
  :hook
  (projectile-switch-project . treemacs-add-and-display-current-project)
  :config
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package centaur-tabs
  :ensure t
  :demand t
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-bar 'under)
  (setq centaur-tabs-cycle-scope 'tabs)
  (centaur-tabs-headline-match))
  
(provide 'init-base)
