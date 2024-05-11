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
	(mapcar #'company-mode/backend-with-yas company-backends)))

;; (use-package company-quickhelp
;;   :custom
;;   (company-quickhelp-delay 1)
;;   :config
;;   (company-quickhelp-mode))

(use-package yasnippet
  :custom
  (yas-snippet-dirs `(,(concat user-emacs-directory "snippets")))
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
  ;; (add-hook 'java-mode-hook 'eglot-ensure)
  ;; (add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-mode)
  (add-hook 'eglot-managed-mode-hook 'hs-minor-mode)
  (add-hook 'eglot-managed-mode-hook 'rc/eglot-mode-hook)
  (add-hook 'eglot-managed-mode-hook 'rc/eglot-keymaps))

;; (use-package eglot-java
;;   :config
;;   (add-hook 'eglot-java-mode-hook 'eglot-java-mode)
;;   ) ; Not working CHECK LATER

;; (add-to-list 'file-name-handler-alist '("\\`jdt://" . eglot-java--jdt-uri-handler))
;; (defun eglot-java--jdt-uri-handler (_operation &rest args)
;;   "Support Eclipse jdtls `jdt://' uri scheme."
;;   (let* ((uri (car args))
;;          (cache-dir (expand-file-name ".eglot-java" (temporary-file-directory)))
;;          (source-file
;;           (expand-file-name
;;            (eglot-java--make-path
;;             cache-dir
;;             (save-match-data
;; 	      (when (string-match "jdt://contents/\\(.*?\\)/\\(.*\\)\.class\\?" uri)
;;                 (format "%s.java" (replace-regexp-in-string "/" "." (match-string 2 uri) t t))))))))
;;     (unless (file-readable-p source-file)
;;       (let ((content (jsonrpc-request (eglot-current-server) :java/classFileContents (list :uri uri)))
;;             (metadata-file (format "%s.%s.metadata"
;;                                    (file-name-directory source-file)
;;                                    (file-name-base source-file))))
;;         (unless (file-directory-p cache-dir) (make-directory cache-dir t))
;;         (with-temp-file source-file (insert content))
;;         (with-temp-file metadata-file (insert uri))))
;;     source-file))

;; (defun eglot-java--make-path (root-dir &rest path-elements)
;;   "Compose a path from a base folder ROOT-DIR and a set of items PATH-ELEMENTS."
;;   (let ((new-path          (expand-file-name root-dir))
;;         (new-path-elements path-elements))
;;     (dolist (p new-path-elements)
;;       (setq new-path (concat (file-name-as-directory new-path) p)))
;;     new-path))

(use-package smartparens
  :hook 
  (prog-mode . smartparens-mode)
  (text-mode . smartparens-mode)
  (markdown-mode . smartparens-mode)
  :config
  ;; load default config
  (require 'smartparens-config))

(use-package drag-stuff
  :config
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys))
