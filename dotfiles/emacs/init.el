;; NOTE: init.el is now generated from Emacs.org. Please edit that file
;;       in Emacs and init.el will be generated automatically!

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)
(setq custom-file null-device)

(setq inhibit-startup-message t)

(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode   -1) ; Disable the toolbar
(tooltip-mode    -1) ; Disable tooltips
(set-fringe-mode 10) ; Adds margins on the sides
(menu-bar-mode   -1) ; Disable the menu bar

(setq visible-bell t) ; Flash notifications

; Soft line wrapping
(global-visual-line-mode)

; Display line and column number
(global-display-line-numbers-mode t)
(column-number-mode t)

; Disable line number for certain modes.
(dolist (mode '(org-mode-hook
  		  term-mode-hook
  		  shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defvar nobbele/font-size 120)
(defvar nobbele/fixed-font "Source Code Pro")
(defvar nobbele/variable-font "Source Sans Pro")

(set-face-attribute 'default nil
  :font nobbele/fixed-font
  :height nobbele/font-size)
(set-face-attribute 'fixed-pitch nil
  :font nobbele/fixed-font
  :height nobbele/font-size)
(set-face-attribute 'variable-pitch nil
  :font nobbele/variable-font)

; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package doom-themes
  :config
  (load-theme 'doom-one t)

  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package swiper)

(use-package ivy
  :diminish
  :init (ivy-mode 1)
  :bind (("C-s" . swiper)))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package counsel
  :init (counsel-mode 1)
  :bind (("M-x"     . counsel-M-x)
	 ("C-x b"   . counsel-switch-buffer)
	 ("C-x C-f" . counsel-find-file)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command]  . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key]      . helpful-key))

(defun nobbele/org-font-setup ()
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(defun nobbele/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0))

(use-package org
  :hook (org-mode . nobbele/org-mode-setup)
  :config
  (nobbele/org-font-setup))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)))

(defun nobbele/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                        (expand-file-name "~/nix-config/dotfiles/emacs/Emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda ()
  (add-hook 'after-save-hook #'nobbele/org-babel-tangle-config)))

(use-package projectile
  :diminish projectile-mode
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (projectile-mode +1)
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :init (counsel-projectile-mode t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
