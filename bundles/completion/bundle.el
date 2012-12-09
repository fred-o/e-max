(defcustom cabbage-completion-framework nil
  "Decide which completion framework (if any) you prefer to
  use with emacs."
  :group 'cabbage
  :type '(choice (const :tag "none" nil)
                 (const :tag "auto-complete" auto-complete)
                 (const :tag "company-mode" company-mode)))

(defcustom cabbage-completion-trigger 1
  "Key binding that triggers completion."
  :group 'cabbage
  :type '(choice (const :tag "None" nil)
                 (const :tag "Ctrl+Space" 1)
                 (const :tag "Alt-/" 2)))

(defcustom cabbage-java-use-eclim t
  "Use eclim for managing java files."
  :type 'boolean
  :group 'cabbage)

(defun cabbage-complete ()
  (interactive)
  "Common completion function that calls the corresponding
function in the chosen completion framework."
  (case cabbage-completion-framework
    ('auto-complete (auto-complete))
    ('company-mode (company-complete))
    ('nil
     (let ((completion-function (cabbage-completion-determine-completion-function)))
       (let ((last-command (and (eq this-command last-command) completion-function))
             (this-command completion-function))
         (call-interactively completion-function))))))

(defun cabbage-completion-determine-completion-function ()
  (cond ((cabbage-lisp-buffer-p) 'lisp-complete-symbol)
                                      (t 'dabbrev-expand)))

(defun cabbage-completion-init ()
  "Initialize cabbage completion"
  (case cabbage-completion-framework
    ('auto-complete
     ;; auto-complete-init
     (message "loading auto-complete")
     (cabbage-vendor 'popup)
     (cabbage-vendor 'auto-complete)
     (require 'auto-complete-config)
     (ac-config-default)
     (setq ac-ignore-case nil)
     (setq ac-delay 0.5)
     ;; enable auto-complete for additional modes
     (setq ac-modes (append ac-modes '(conf-unix-mode haml-mode))))
    ('company-mode
     ;; company-mode init
     (cabbage-vendor 'company)
     (global-company-mode)))
  (case cabbage-completion-trigger
    (1 (global-set-key (kbd "C-SPC") 'cabbage-complete))
    (2 (define-key esc-map "/" 'cabbage-complete)))

  
  (when cabbage-java-use-eclim
    (add-to-list 'load-path (concat (cabbage-vendor-library-dir 'eclim) "vendor/"))
    (cabbage-vendor 'eclim)

    (setq eclim-interactive-completion-function 'ido-completing-read)

    (setq help-at-pt-display-when-idle t)
    (setq help-at-pt-timer-delay 0.1)
    (help-at-pt-set-timer)

    (global-eclim-mode t)

    (case cabbage-completion-framework
      ('auto-complete
       (require 'ac-emacs-eclim-source)
       (ac-emacs-eclim-config))
      ('company-mode
       (require 'company-emacs-eclim)
       (company-emacs-eclim-setup)))

    ;; If we are using the snippets bundle, append the eclim
    ;; yasnippets dir to the list of yasnippet directories
    (if (and eclim-use-yasnippet (cabbage-bundle-active-p 'snippets))
        (add-hook 'cabbage-initialized-hook
                  (lambda ()
                    (let ((dir (concat (cabbage-vendor-library-dir 'eclim) "snippets/")))
                      (add-to-list 'yas/root-directory dir t)
                      (yas/load-directory dir)))))))

(cabbage-completion-init)

(cabbage-vendor 'smex)

;;;; Smex Completion for M-x
(smex-initialize)

;;;; Global IDO Completion
(ido-everywhere t)

(cabbage-vendor 'ido-ubiquitous)
(add-to-list 'ido-ubiquitous-command-exceptions 'ucs-insert)
(ido-ubiquitous t)
