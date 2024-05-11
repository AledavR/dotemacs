;; CUSTOM FUNCTIONS
(defvar rc/latex-subdir-plural
  '("figure" "table" "image" "section")
  "List of latex filetypes which need a plural form")

(defun rc/is-main-latex-file ()
  "Returns t if the current file is the main tex file, nil otherwise"
  (when (equal (file-name-base buffer-file-name) "main") t))

(defun rc/latex-file-subdirectory (filetype)
  "Define the subdirectory in a latex project for the filetype submitted as
input"
  (let* ((file-path-prefix
	  (if (rc/is-main-latex-file) "./" "../"))
	 (file-type-subdir
	  (if (member filetype rc/latex-subdir-plural)
	      (concat filetype "s/")
	    (concat filetype "/")))
	 (file-type-subdir-with-prefix
	  (concat file-path-prefix file-type-subdir))
	 (file-path
	  (read-file-name "File: " file-type-subdir-with-prefix "" t))
	 (file-relative-path
	  (replace-regexp-in-string
	   (concat ".*" file-type-subdir "\\(.*\\)")
	   (concat file-type-subdir-with-prefix "\\1") file-path)))
    (format "%s" file-relative-path)))

(defun rc/latex-insert-file (&optional filetype)
  "Insert the relative path to a latex extra file in a subdirectory"
  (interactive "P")
  (if filetype
      (let ((filepath
	     (rc/latex-file-subdirectory filetype)))
	(insert filepath))
    (let* ((filetype
	    (completing-read "File type: "
			     '("image" "figure" "table" "code" "section") nil t))
	   (filepath
	    (rc/latex-file-subdirectory filetype)))
      (insert filepath))))

(defun rc/cdlatex-pos-cursor-insert-file (&optional filetype)
  "Function to use in cdlatex command completion"
  (cdlatex-position-cursor)
  (if filetype
      (rc/latex-insert-file filetype)
    (let ((filetype (completing-read
		     "File type: " '("figure" "table" "section") nil t)))
      (rc/latex-insert-file filetype))))

(defun rc/latex-array-separation ()
  (when (line-contains? "&")
      (progn
	(replace-regexp-in-line "&" " & ")
	(LaTeX-indent-line)
	(beginning-of-line-text)
	(left-char 1))))

(advice-add 'LaTeX-insert-item :after #'rc/latex-array-separation)

;; PACKAGES

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :hook ((pdf-view-mode . pdf-links-minor-mode)
	 (pdf-view-mode . pdf-view-themed-minor-mode)
	 (pdf-view-mode . pdf-sync-minor-mode))
  :custom
  (pdf-view-display-size 'fit-width "Fit to width by default")
  (pdf-annot-activate-created-annotations t "Activate annotations")
  :config
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (define-key pdf-view-mode-map (kbd "C-r") 'isearch-backward))
;; Not working (TODO)

;; (use-package xenops)

(use-package cdlatex
  :preface
  (defvar rc/cdlatex-env-list
    '(("axiom" "\\begin{axiom}\nLABEL\n?\n\\end{axiom}\n" nil)
      ("theorem" "\\begin{theorem}\nLABEL\n?\n\\end{theorem}\n" nil))
    "cdlatex enviroments")
  (defvar rc/cdlatex-command-list
    '(("ref"
       "Insert a new reference"
       "" consult-reftex-insert-reference nil t nil)
      ("gph"
       "Insert an image"
       "\\includegraphics[width=0.6\\linewidth]{?}"
       rc/cdlatex-pos-cursor-insert-file ("image") t nil)
      ("inp"
       "Input a file"
       "\\input{?}"
       rc/cdlatex-pos-cursor-insert-file nil t nil)
      ("inc"
       "Include a file"
       "\\include{?}"
       rc/cdlatex-pos-cursor-insert-file nil t nil)
      ("dm"
       "Insert a math display block"
       "\\[\n  ?\n\\]" cdlatex-position-cursor nil t nil)
      ("mm"
       "Insert an inline math block"
       "\\( ? \\)" cdlatex-position-cursor nil t nil)
      ("sci"
       "Insert scientific notation"
       "\\times 10^{?}" cdlatex-position-cursor nil nil t))
    "cdlatex custom commands")
  :init
  (setq cdlatex-env-alist rc/cdlatex-env-list
	cdlatex-command-alist rc/cdlatex-command-list)
  :bind ( :map cdlatex-mode-map
	  ("C-<return>" . nil)
	  ("´" . cdlatex-math-symbol)
	  ("<tab>" . cdlatex-tab)))

(use-package consult-reftex
  :elpaca (consult-reftex :type git
			  :host github
			  :repo "karthink/consult-reftex"))

(use-package citar)

(use-package auctex
  :elpaca ( :pre-build (("./autogen.sh")
			("./configure"
			 "--without-texmf-dir"
			 "--with-packagelispdir=./"
			 "--with-packagedatadir=./")
			("make")))
  ;; :mode ("\\.tex\\'" . LaTeX-mode)
  :preface
  (defun rc/TeX-arg-trig (optional &optional prompt)
    "Prompt for a trigonometric function.
Serves as a reminder of how to implement it"
    (TeX-argument-insert
     (completing-read
      (TeX-argument-prompt optional prompt "Funcion trigonometrica")
      '("sen" "cos" "sec" "csc" "tg" "ctg"))
     optional))
  (defun rc/auctex-macros ()
    "Defines custom macros to insert in LaTeX mode"
    (TeX-add-symbols
     '("texcount" (rc/TeX-arg-trig))
     '("texcounter" [ (TeX-arg-corner "Esto es un prompt: ") ] TeX-arg-counter )))
  (defvar rc/tex-symbols-list
    '(("\\blank" . ?—)
      ("\\otimes" . ?⨂ ))
    "List of custom symbols for LaTeX")
  (defun rc/append-tex-symbols-list ()
    "Appends the custom symbols list to the default list removing duplicates"
    (setq-default tex--prettify-symbols-alist
		  (TeX-delete-dups-by-car
		   (append rc/tex-symbols-list
			   tex--prettify-symbols-alist))))
  (defun rc/latex-init ()
    "Defines what modes are activated by default when entering AuCtex mode"
    (prettify-symbols-mode)
    (turn-on-cdlatex)
    (outline-minor-mode)
    (rc/auctex-macros)
    (TeX-source-correlate-mode t)
    (tex-fold-mode 1)
    (TeX-PDF-mode t)
    (reftex-mode t)
    (LaTeX-math-mode t))
  ;; DON'T USE HOOKS THIS WAY, IT MESS WITH THE INSTALLATION
  ;; :hook ((latex-mode . TeX-latex-mode)
  ;; 	 (LaTeX-mode . prettify-symbols-mode)
  ;; 	 (LaTeX-mode . rc/latex-init)
  ;; 	 (LaTeX-mode . turn-on-cdlatex)
  ;; 	 ;; (LaTeX-mode . yas-minor-mode)
  ;; 	 (LaTeX-mode . rc/auctex-macros))
  :init
  ;; Correct way to call hooks for auctex
  (add-hook 'LaTeX-mode-hook 'rc/latex-init) 
  (setopt
   TeX-fold-macro-spec-list
   '(("{1}" ("emph"))
     ("{1}" ("textbf"))
     ("{1}" ("textit"))
     ("[1]:||►" ("item"))
     ;; ("‡ {1}" ("label"))
     ("§ {1}" ("section" "section*"))
     ("[f]→‖{1}‖" ("footnote" "marginpar"))
     ("[c]→‖{1}‖" ("cite"))
     ("[l]→‖{1}‖" ("label"))
     ("[r]→‖{1}‖" ("ref" "pageref" "eqref" "footref"))
     ("[i]→‖{1}‖" ("index" "glossary"))
     ("§§ {1}" ("subsection" "subsection*"))
     ("§§§ {1}" ("subsubsection" "subsubsection*"))
     ("¶¶ {1}" ("subparagraph" "subparagraph*"))
     ("¶ {1}" ("paragraph" "paragraph*"))))
  (setq-default TeX-source-correlate-method 'synctex
		TeX-source-correlate-start-server t
		TeX-master nil
		TeX-view-program-selection '((output-pdf "PDF Tools")))
  ;; (setq-default TeX-source-correlate-method 'synctex)
  ;; (setq-default TeX-source-correlate-start-server t)
  ;; (setq-default TeX-master nil)
  ;; (setq-default TeX-view-program-selection '((output-pdf "PDF Tools")))
  (add-hook 'TeX-after-compilation-finished-functions
	    #'TeX-revert-document-buffer)
  (eval-after-load 'tex
    '(define-key TeX-source-correlate-map [C-mouse-9]
		 #'TeX-view-mouse))
  (eval-after-load 'tex 'rc/append-tex-symbols-list)
  :custom
  (TeX-parse-self t "Enable parse on load")
  (TeX-auto-save t "Enable parse on save")
  (TeX-arg-input-file-search 'nil "Find file manually")
  (preview-auto-cache-preamble nil)
  ;; (LaTeX-electric-left-right-brace t)
  :config
  (setq-default preview-scale 1.4
		preview-scale-function
		(lambda () (* (/ 10.0 (preview-document-pt)) preview-scale))))

;; (use-package auctex-latexmk
;;   :after tex
;;   :custom
;;   (auctex-latexmk-inherit-TeX-PDF-mode t)
;;   :config
;;   (auctex-latexmk-setup))

;; (use-package preview
;;   :after latex
;;   :hook ((LaTeX-mode . preview-larger-previews))
;;   :config
;;   (defun preview-larger-previews ()
;;     (setq preview-scale-function
;;           (lambda () (* 1.25
;;                    (funcall (preview-scale-from-face)))))))

;; (use-package company-auctex
;;   :after tex
;;   :init
;;   (company-auctex-init))
