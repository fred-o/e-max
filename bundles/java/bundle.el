
(defun cabbage-java-init ()
  "Initialize the java bundle."

  (cabbage-vendor 'java-mode-indent-annotations)
  (add-hook 'java-mode-hook 'java-mode-indent-annotations-setup))

(cabbage-java-init)
