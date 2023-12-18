(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(use-package vertico
  :elpaca (vertico :type git :host github :repo "minad/vertico"
		   :files (:defaults "extensions/*"))
  :init
  (vertico-mode)
  :custom
  ;;(vertico-resize t)
  (vertico-cycle t)
  (vertico-count 15))

(use-package vertico-directory
  :elpaca nil
  :after vertico
  :ensure nil
  :bind (:map vertico-map
	      ("RET" . vertico-directory-enter)
	      ("DEL" . vertico-directory-delete-char)
	      ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :config
  (marginalia-mode))

(use-package consult)
