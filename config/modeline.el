(defvar-local my-mode-line-buffer-name
    '(:eval
      (format " %s "
	      (if (and (buffer-modified-p) (not buffer-read-only))
		  (propertize (buffer-name) 'face 'mode-line-emphasis)
	      (propertize (buffer-name) 'face 'icon))))
  "Modeline variable that returns the name of the buffer")

(put 'my-mode-line-buffer-name 'risky-local-variable t)

(defun my-local--major-mode ()
  "Returns capitalized major mode"
  ;;(capitalize (symbol-name major-mode)))
  (symbol-name major-mode))

(defvar-local my-mode-line-major-mode
    '(:eval
      (when (mode-line-window-selected-p)
	(format "  %s  "
		(propertize (my-local--major-mode) 'face 'mode-line))))
  "Modeline variable that returns the major mode of the buffer")

(put 'my-mode-line-major-mode 'risky-local-variable t)

(setq mode-line-end-spaces
      '(""
	(vc-mode vc-mode)
	" "
	"%I "
	" %l:%c"
	))

(defun my-mode-line/padding ()
  (let ((r-length (length (format-mode-line mode-line-end-spaces))))
    (propertize " "
		'display `(space :align-to (- right ,r-length)))))

(defvar-local my-mode-line-mode-tag
    '(:eval (when (mode-line-window-selected-p)
	      evil-mode-line-tag))
  "Shows the current editor mode")

(put 'my-mode-line-mode-tag 'risky-local-variable t)

(setq evil-insert-state-tag (propertize "INSERT" 'face 'warning)
      evil-normal-state-tag (propertize "NORMAL" 'face 'success)
      evil-emacs-state-tag (propertize "EMACS" 'face 'warning)
      evil-visual-block-tag (propertize "VISUAL BL" 'face 'error)
      evil-visual-line-tag (propertize "VISUAL LN" 'face 'error)
      evil-visual-char-tag (propertize "VISUAL" 'face 'error))

(setq-default mode-line-format
      '("%e "
	my-mode-line-buffer-name
	my-mode-line-major-mode
	my-mode-line-mode-tag
	(:eval (my-mode-line/padding))
	(:eval (when (mode-line-window-selected-p)
		 mode-line-end-spaces))))


;; (setq-default header-line-format
;; 	      '(
;; 		" "
;; 		my-mode-line-buffer-name
;; 		;; my-mode-line-save-state
;; 		))
