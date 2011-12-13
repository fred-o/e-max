(e-max-vendor 'haml-mode)
(e-max-vendor 'sass-mode)
(e-max-vendor 'scss-mode)

(setq scss-compile-at-save nil)

(add-hook 'haml-mode-hook 'e-max-autopair-pipe)
(add-hook 'haml-mode-hook 'e-max-autopair-singlequote)