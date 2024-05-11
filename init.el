;; Set up package manager
(load (concat user-emacs-directory "config/elpaca.el"))

(elpaca-wait)

;; Custom definitions
(load (concat user-emacs-directory "config/definitions.el"))

(use-package emacs
  :elpaca nil
  :custom
  (recentf-save-file (concat user-emacs-directory "temporal/recentf"))
  ;; (make-backup-files nil) ; Don't make backups
  (auto-save-default nil) ; Don't autosave
  (org-image-actual-width 700) ; Define size of images
  (backup-directory-alist `(("." . ,(concat user-emacs-directory "saves"))))
  (browse-url-browser-function 'browse-url-generic)
  (browse-url-generic-program "vivaldi-stable")
  (inhibit-startup-message t) ; Don't bother me
  (x-select-enable-clipboard t)
  (ring-bell-function 'ignore)
  (c-basic-offset tab-width)
  (backward-delete-char-untabify-method 'nil)
  (initial-scratch-message ";; Scratch buffer for emacs-lisp-mode")
  (frame-resize-pixelwise t)
  (fast-but-imprecise-scrolling t)
  (tab-always-indent 'complete)
  (use-dialog-box nil) ; No GUI elements
  (history-length 25)
  ;; (eldoc-echo-area-use-multiline-p nil)
  (org-agenda-tags-column 0)
  (recentf-exclude '(".*gz"
		     ".*pdf"
		     "bookmarks"
		     ".*log"
		     ".*png"
		     ".*jpg"
		     ".*gif"
		     ".*_db"))
  :config
  ;; Declutter UI
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (recentf-mode 1)
  (repeat-mode)
  (pixel-scroll-precision-mode t) ; Smooth scrolling
  (defalias 'yes-or-no-p 'y-or-n-p) ; Alias yes-or-no
  ;; Line numbers in programming files
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (add-hook 'emacs-lisp-mode-hook 'emacs-lisp-pretty-icons)
  (add-hook 'java-mode-hook (lambda ()
			      (setq c-basic-offset 4
				    tab-width 4
				    indent-tabs-mode t)))
  ;; (set-frame-size-aecording-to-resolution)
  (setq-default fill-column 80) ; Ruler at line 80
  (setq-default display-line-numbers-type 'visual)
  (setq-default display-line-numbers-width 3)
  (setq-default display-line-numbers-grow-only t)
  (setq-default prettify-symbols-unprettify-at-point 'right-edge)
  ;; Start Emacs maximized
  (add-to-list 'default-frame-alist
	       '(fullscreen . maximized))
  ;; Font family and size
  (add-to-list 'default-frame-alist
	       '(font . "mononoki Nerd Font Mono:style=Regular"))
  ;; (add-to-list 'recentf-exclude "bookmarks")
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((octave . t)))
  )

(use-package server
  :elpaca nil
  :config
  (unless (server-running-p)
    (server-start)))


;; CONFIG 

;; Evil general (Keybinds)
(load (concat user-emacs-directory "config/keybinds.el"))

;; Dashboard setup
(load (concat user-emacs-directory "config/dashboard.el"))

;; Nerd Icons
(use-package nerd-icons)

;; UI
(load (concat user-emacs-directory "config/ui.el"))

;; Project
(load (concat user-emacs-directory "config/project.el"))

;; Tools
(load (concat user-emacs-directory "config/tools.el"))

;; Modeline
(load (concat user-emacs-directory "config/modeline.el"))

;; Tabline
;; (load (concat user-emacs-directory "config/tabline.el"))

;; Minibuffer
(load (concat user-emacs-directory "config/minibuffer.el"))

;; LaTeX
(load (concat user-emacs-directory "config/latex.el"))

;; Org Mode
(load (concat user-emacs-directory "config/org.el"))

;; Code
(load (concat user-emacs-directory "config/code.el"))

;; Java
;; (load (concat user-emacs-directory "config/java.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("45e409674661674c12070af5f8ef71741599eeb9fccd84557f1b822509f3b100" "4ae2387bb3bcfb3419d88f586b41c1fef3ff8620b80d06d53f98ec30df469407" "38457f8afb329ce87e1a41d31e155acb4dcdf5ee6a1ea703d401f2042747a69f" default))
 '(ignored-local-variable-values '((TeX-master . t)))
 '(package-selected-packages '(eglot auctex))
 '(safe-local-variable-values
   '((eval TeX-run-style-hooks "beamer")
     (TeX-master . "../main"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'TeX-narrow-to-group 'disabled nil)
(put 'LaTeX-narrow-to-environment 'disabled nil)
