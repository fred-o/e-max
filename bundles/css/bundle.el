;; File Mappings
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

(defun e-max-css-set-indenting ()
  (setq css-indent-level 2)
  (setq css-indent-offset 2))

(add-hook 'css-mode-hook 'e-max-css-set-indenting)
