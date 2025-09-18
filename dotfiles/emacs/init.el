(require 'cl-lib)

(setq inhibit-startup-message t)
(tool-bar-mode -1)

(load "~/Projects/mymake/mm-compile.el")
(setq mymake-command "mm")

(load "~/Projects/storm-3d/Plugin/emacs.el")
(setq storm-mode-compiler "~/Projects/storm-3d/debug/Storm")
(setq storm-mode-root "~/Projects/storm-3d/root")

(global-storm-mode t)