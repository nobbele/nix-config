(use-package eat
  :ensure t
  :preface
  (defvar my/eat-buffer-name "*eat*"
    "Name of the main Eat terminal buffer.")
  (defun my/toggle-eat ()
    "Toggle Eat terminal in a bottom window."
    (interactive)
    (let ((buf (get-buffer my/eat-buffer-name)))
      (if (and buf (get-buffer-window buf))
        ;; If visible → close it
        (delete-window (get-buffer-window buf))
        ;; Else → create or show it at the bottom
        (let ((win (split-window (frame-root-window) -15 'below)))
          (select-window win)
          (if buf
              (switch-to-buffer buf)
            (eat))))))
  :config
  (setq eat-query-before-killing-running-terminal nil)
  (setq eat-kill-buffer-on-exit t)
  :bind
  (:map global-map
        ([f9] . my/toggle-eat)))

(provide 'init-term)
