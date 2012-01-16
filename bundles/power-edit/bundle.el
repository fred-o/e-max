(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))


(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))


(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun forward-buffer () (interactive)
  "Opposite of backward-buffer."
  (let* ((list (reverse (buffer-list)))
         (buffer (car list)))
    (while (and (cdr list) (string-match "\\*" (buffer-name buffer)))
      (progn
        (setq list (cdr list))
        (setq buffer (car list))))
    (switch-to-buffer buffer)))

(defun backward-buffer () (interactive)
  "Switch to previously selected buffer."
  (let* ((list (cdr (buffer-list)))
         (buffer (car list)))
    (while (and (cdr list) (string-match "\\*" (buffer-name buffer)))
      (progn
        (setq list (cdr list))
        (setq buffer (car list))))
    (bury-buffer)
    (switch-to-buffer buffer)))

(e-max-vendor 'textmate)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)
(global-set-key (kbd "M-<right>")  'textmate-shift-right)
(global-set-key (kbd "M-<left>") 'textmate-shift-left)

;; Do not e-max-global-set-key TAB because this would override local
;; bindings such as in magit.
(global-set-key (kbd "TAB") 'e-max-smart-tab)

;; Autopair
(e-max-vendor 'autopair)
(autopair-global-mode)


(defun e-max-autopair-gt-lt ()
  "Enables autopairing of < and >."
  (if (boundp 'autopair-extra-pairs) (push '(?< . ?>) (getf autopair-extra-pairs :code))))

(defun e-max-autopair-pipe ()
  "Enables autopairing of the | character."
  (if (boundp 'autopair-extra-pairs) (modify-syntax-entry ?| "\"")))

(defun e-max-autopair-backtick ()
  "Enables autopairing of the | character."
  (if (boundp 'autopair-extra-pairs) (modify-syntax-entry ?` "\"")))

(defun e-max-autopair-triplequote()
  "Enables autoparing of '''"
  (if (boundp 'autopair-extra-pairs)
      (setq autopair-handle-action-fns
            (list #'autopair-default-handle-action
                  #'autopair-python-triple-quote-action))))


