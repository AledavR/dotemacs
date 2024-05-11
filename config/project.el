;; (use-package skeletor
;;   :custom
;;   (skeletor-project-directory "~/Files/workspace/projects/")
;;   :config
;;   (skeletor-define-template "latex-article"
;;     :title "LaTeX Article"
;;     :no-license? t)
;;   (skeletor-define-template "LaTeX-APA7"
;;     :title "LaTeX APA 7th Article"
;;     :no-license? t)
;;   (skeletor-define-template "latex-beamer"
;;     :title "LaTeX Beamer"
;;     :no-license? t))

(use-package logos
  :config
  (setq-default logos-hide-cursor nil
		logos-hide-mode-line t
		logos-hide-buffer-boundaries t
		logos-hide-fringe t
		logos-variable-pitch nil
		logos-buffer-read-only nil
		logos-scroll-lock nil
		logos-olivetti nil)
  (let ((map global-map))
    (define-key map [remap narrow-to-region] #'logos-narrow-dwim)
    (define-key map [remap forward-page] #'logos-forward-page-dwim)
    (define-key map [remap backward-page] #'logos-backward-page-dwim)
    (define-key map (kbd "<f9>") #'logos-focus-mode)))

(use-package magit)

(use-package transient)
