(use-package ef-themes 
  ;; :custom 
  ;; (ef-themes-mixed-fonts t)
  ;; (ef-themes-variable-pitch-ui t)
  ;; (ef-themes-headings ; read the manual's entry or the doc string
  ;;  '((0 variable-pitch light 1.9)
  ;;    (1 variable-pitch light 1.8)
  ;;    (2 variable-pitch regular 1.7)
  ;;    (3 variable-pitch regular 1.6)
  ;;    (4 variable-pitch regular 1.5)
  ;;    (5 variable-pitch 1.4) ; absence of weight means `bold'
  ;;    (6 variable-pitch 1.3)
  ;;    (7 variable-pitch 1.2)
  ;;    (t variable-pitch 1.1)))
  :config
  (mapc #'disable-theme custom-enabled-themes)
  (ef-themes-select 'ef-elea-dark)
  (setq ef-themes-to-toggle '(ef-elea-dark ef-cyprus))
  )
;; Make customisations that affect Emacs faces BEFORE loading a theme
;; (any change needs a theme re-load to take effect).

;; If you like two specific themes and want to switch between them, you
;; can specify them in `ef-themes-to-toggle' and then invoke the command
;; `ef-themes-toggle'.  All the themes are included in the variable
;; `ef-themes-collection'.
;; (setq ef-themes-to-toggle '(ef-summer ef-winter))


;; They are nil by default...

;; Disable all other themes to avoid awkward blending:

;; Load the theme of choice:
;;(load-theme 'ef-summer :no-confirm)

;; OR use this to load the theme which also calls `ef-themes-post-load-hook':

;; The themes we provide are recorded in the `ef-themes-dark-themes',
;; `ef-themes-light-themes'.

;; We also provide these commands, but do not assign them to any key:
;;
;; - `ef-themes-toggle'
;; - `ef-themes-select'
;; - `ef-themes-select-dark'
;; - `ef-themes-select-light'
;; - `ef-themes-load-random'
;; - `ef-themes-preview-colors'
;; - `ef-themes-preview-colors-current'

;; (use-package origami)
(use-package writeroom-mode)

(use-package treemacs)
