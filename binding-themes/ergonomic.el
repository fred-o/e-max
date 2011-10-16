(e-max-bindings-make-theme
 "Ergonomic"
 (("M-l" . move-char-forward)
  ("M-j" . move-char-backward)
  ("M-i" . move-previous-line)
  ("M-k" . move-next-line)
  ("M-J" . move-beginning-of-line)
  ("M-L" . move-end-of-line)
  ("M-o" . move-word-forward)
  ("M-u" . move-word-backward)
  ("M-O" . move-paragraph-forward)
  ("M-U" . move-paragraph-backward)
  ("M-b" . move-previous-mark-position)

  ("M-K" . scroll-next-page)
  ("M-I" . scroll-previous-page)

  ("M-f" . delete-char-forward)
  ("<kp-delete>" . delete-char-forward)
  ("M-d" . delete-char-backward)
  ("<backspace>" . delete-char-backward)

  ("M-0" . window-delete-current)
  ("M-2" . window-split-top-to-bottom)
  ("M-3" . window-split-side-by-side)
  ("M-4" . window-split-balance)
  ("M-+" . window-split-balance)
  ))
