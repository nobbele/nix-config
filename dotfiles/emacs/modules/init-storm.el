(require 'cl-lib)

(load "~/Projects/mymake/mm-compile.el")
(setq mymake-command "mm")

(load "~/Projects/storm/Plugin/emacs.el")
(setq storm-mode-compiler "~/Projects/storm/debug/Storm")
(setq storm-mode-root "~/Projects/storm/root")

(global-storm-mode t)

(provide 'init-storm)