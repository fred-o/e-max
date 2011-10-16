(defvar e-max-bindings-global-store (make-hash-table :test 'equal)
  "Hash to store global binding definitions")

(defun e-max-bindings-define-global (name function)
  (puthash name function e-max-bindings-global-store))

(e-max-bindings-define-global 'move-char-forward 'forward-char)
(e-max-bindings-define-global 'move-char-backward 'backward-char)
(e-max-bindings-define-global 'move-word-backward 'backward-word)
(e-max-bindings-define-global 'move-word-forward 'forward-word)
(e-max-bindings-define-global 'move-paragraph-forward 'forward-paragraph)
(e-max-bindings-define-global 'move-paragraph-backward 'backward-paragraph)
(e-max-bindings-define-global 'move-previous-line 'previous-line)
(e-max-bindings-define-global 'move-next-line 'next-line)
(e-max-bindings-define-global 'move-end-of-line 'end-of-line)
(e-max-bindings-define-global 'move-beginning-of-line 'beginning-of-line)
(e-max-bindings-define-global 'move-previous-mark-position 'pop-to-mark-command)

(e-max-bindings-define-global 'scroll-next-page 'scroll-up)
(e-max-bindings-define-global 'scroll-previous-page 'scroll-down)

(e-max-bindings-define-global 'delete-char-forward 'delete-char)
(e-max-bindings-define-global 'delete-char-backward 'delete-backward-char)

(e-max-bindings-define-global 'window-split-side-by-side 'split-window-horizontally)
(e-max-bindings-define-global 'window-split-top-to-bottom 'split-window-vertically)
(e-max-bindings-define-global 'window-delete-current 'delete-window)
(e-max-bindings-define-global 'window-delete-others 'delete-other-windows)
(e-max-bindings-define-global 'window-split-balance 'balance-windows)

(defmacro* e-max-bindings-make-theme (name bindings)
  (let ((binding-theme-function-symbol
         (intern (concat "binding-theme-"
                         (replace-regexp-in-string "\s" "-" (downcase name)))))
        (binding-description
         (concat "Binding theme " name)))
    `(progn
       (defun ,binding-theme-function-symbol ()
         ,binding-description
         (interactive)
         (dolist (binding-definition (quote ,bindings))
             (let ((key-stroke (car binding-definition))
                   (function (cdr binding-definition)))
               (e-max-global-set-key (read-kbd-macro key-stroke)
                                     (gethash function e-max-bindings-global-store))))))))

