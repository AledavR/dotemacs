
(defvar home-dir "/home/rcaled/"
  "Home directory")
(defvar internal-disk "/media/InternalDisk/"
  "Internal disk directory")
(defvar external-disk "/media/ExternalDisk/"
  "External disk directory")
(defvar important-dir
  (concat internal-disk "Data/Important/")
  "Important files directory")

(defun line-contains? (string)
  (s-contains? string
	       (buffer-substring-no-properties
		(line-beginning-position)
		(line-end-position))))

(defun replace-regexp-in-line (regexp replacement)
  (replace-regexp regexp replacement nil
   (line-beginning-position)
   (line-end-position)))

(defun config-visit ()
  "Visit the default init.el file"
  (interactive)
  (find-file (concat user-emacs-directory "/init.el")))

;; (defun config-reload ()
;;   "Reloads ~/.emacs.d/config.org at runtine"
;;   (interactive)
;;   (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))

(defun create-scratch-buffer ()
  "Create a scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode))

(defun rc/export-code-block-for-message (start end)
  "Copy current region and format it to a markdown codeblock"
  (interactive "r")
  (setq code-block (buffer-substring start end))
  (setq code-block-formatted (concat "```\n" code-block "```"))
  (deactivate-mark)
  (kill-new code-block-formatted))


(defun emacs-lisp-pretty-icons ()
  "Pretty icons for emacs-lisp-mode"
  (setq prettify-symbols-alist '(("nil" . "∅")
				 ("t" . "⊤")
				 ("lambda" . "λ")
				 ("" . "Ⓟ")))
  (prettify-symbols-mode))

(defun position-to-kill-ring ()
  "Copy to the kill ring a string in the format \"file-name:line-number\"
for the current buffer's file name, and the line number at point."
  (interactive)
  (kill-new
   (format "%s::%d" (buffer-file-name) (save-restriction
                                        (widen) (line-number-at-pos)))))

;; (defun set-frame-size-according-to-resolution ()
;;   (interactive)
;;   ;; (if window-system
;;   ;; (if (display-graphic-p)
;;       (progn
;; 	;; use 120 char wide window for largeish displays
;; 	;; and smaller 80 column windows for smaller displays
;; 	;; pick whatever numbers make sense for you
;; 	(if (> (x-display-pixel-width) 1280)
;; 	    (add-to-list 'default-frame-alist (cons 'width 120))
;; 	  (add-to-list 'default-frame-alist (cons 'width 80)))
;; 	;; for the height, subtract a couple hundred pixels
;; 	;; from the screen height (for panels, menubars and
;; 	;; whatnot), then divide by the height of a char to
;; 	;; get the height we want
;; 	(add-to-list 'default-frame-alist 
;; 		     (cons 'height (/ (- (x-display-pixel-height) 200)
;; 				      (frame-char-height))))))
