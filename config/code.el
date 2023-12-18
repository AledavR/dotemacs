(use-package company
;;   :preface
;;   (defun deactivate-tab-company ()
;;     "Deactivates the <tab> keymap because of the collisions
;; with yasnippet and cdlatex"
;;     (interactive)
;;     (define-key company-active-map (kbd "<tab>") nil))
;;   :hook
;;   ;; (company-mode . deactivate-tab-company)
;;   (company-mode
;;    . (lambda () (general-define-key
;; 	    :keymaps 'company-active-map
;; 	    "<tab>" nil)))
  :custom
  (company-idle-delay 0.5 "Delay until completions are shown")
  :config
  (global-company-mode)
  ;; (setq company-idle-delay 0.5)
  ;; weight by frequency
  (setq company-transformers '(company-sort-by-occurrence))
  (defvar company-mode/enable-yas t "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas)
	    (and (listp backend) (member 'company-yasnippet backend)))
	backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends
	(mapcar #'company-mode/backend-with-yas company-backends))
  )

(use-package company-quickhelp
  :custom
  (company-quickhelp-delay 1)
  :config
  (company-quickhelp-mode))

(use-package yasnippet
  :custom
  (yas-snippet-dirs '("~/.emacs.d/snippets"))
  :config
  (yas-global-mode 1))

;; (use-package tree-sitter-langs)

(use-package eldoc-box)

(use-package eglot
  :elpaca nil
  :after company eldoc-box
  :init
  (defun rc/eglot-keymaps ()
    (general-define-key
     :keymaps 'eglot-mode-map
     :states 'normal
     "K" 'eldoc-box-help-at-point))
  (defun rc/eglot-mode-hook ()
    (set (make-local-variable 'company-backends)
	 '((company-yasnippet
	    :separate company-keywords
	    :separate company-capf))))
  :config
  (add-hook 'eglot-managed-mode-hook 'rc/eglot-mode-hook)
  (add-hook 'eglot-managed-mode-hook 'rc/eglot-keymaps))

(use-package smartparens
  :hook 
  (prog-mode . smartparens-mode)
  (text-mode . smartparens-mode)
  (markdown-mode . smartparens-mode)
  :config
  ;; load default config
  (require 'smartparens-config)
  )

(use-package skeletor
  :custom
  (skeletor-project-directory "~/Documents/Projects")
  :config
  (skeletor-define-template "latex-article"
    :title "LaTeX Article"
    :no-license? t)
  (skeletor-define-template "LaTeX-APA7"
    :title "LaTeX APA 7th Article"
    :no-license? t)
  (skeletor-define-template "latex-beamer"
    :title "LaTeX Beamer"
    :no-license? t))

(use-package magit)
(use-package transient)
