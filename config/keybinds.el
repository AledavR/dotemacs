(use-package general
  :config

  ;; General keybindings
  (general-create-definer rc/leader-keys
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    )

  (rc/leader-keys
    "RET" '(consult-bookmark :which-key "search bookmark")

    "a" '(:ignore t :which-key "applications")
    "af"'(elfeed :which-key "elfeed")

    "f" '(:ignore t :which-key "file")
    "ff" '(find-file :which-key "search file")
    "fr" '(consult-recent-file :which-key "recent files")
    "fw" '(save-buffer :which-key "save file")
    "fW" '(write-file :which-key "save file as")

    "b" '(:ignore t :which-key "buffer")
    "bc" '(kill-current-buffer :which-key "kill buffer")
    "bC" '(kill-buffer-and-window :which-key "kill buffer and window")
    "be" '(eval-buffer :which-key "eval buffer")
    "bs" '(consult-buffer :which-key "switch buffer")

    "w"  '(:ignore t :which-key "window")
    ;; Creation and deletion
    "wv" '(evil-window-vsplit :which-key "window vsplit")
    "ws" '(evil-window-split :which-key "window hsplit")
    "wc" '(evil-window-delete :which-key "close window")
    "wf" '(ffap-other-window :which-key "open file in other window")
    "wo" '(delete-other-windows :which-key "delete other windows")
    "wn" '(evil-window-new :which-key "new scratch windows")
    ;; Position control
    "wx" '(evil-window-exchange :which-key "switch windows")
    "wr" '(evil-window-rotate-downwards :which-key "rotate down")
    "wR" '(evil-window-rotate-upwards :which-key "rotate up")
    "wH" '(evil-window-move-far-left :which-key "move left")
    "wJ" '(evil-window-move-very-bottom :which-key "move down")
    "wK" '(evil-window-move-very-top :which-key "move up")
    "wL" '(evil-window-move-far-right :which-key "move right")
    ;; Height and width
    "w_" '(evil-window-set-width :which-key "maximize width")
    "w|" '(evil-window-set-height :which-key "maximize height")
    ;; Focus control
    "ww" '(evil-window-next :which-key "next")
    "wp" '(evil-window-prev :which-key "prev")
    "wh" '(evil-window-left :which-key "left")
    "wj" '(evil-window-down :which-key "bottom")
    "wk" '(evil-window-up :which-key "top")
    "wl" '(evil-window-right :which-key "right")
    ;; Extra (winner-mode)
    ;; "w <right>" '(winner-redo :which-key "redo")
    ;; "w <left>" '(winner-undo :which-key "undo")

    "p" '(:ignore t :which-key "project")
    "pp" '(project-switch-project :which-key "switch")
    "pK" '(project-kill-buffers :which-key "kill buffers")
    "pb" '(consult-project-buffer :which-key "buffers")
    "pf" '(project-find-file :which-key "files")
    "pf" '(project-query-replace-regexp :which-key "replace query")
    "pd" '(project-find-dir :which-key "directory")
    "pD" '(project-dired :which-key "dired")
    "ps" '(project-shell-command :which-key "command")
    "pS" '(project-shell :which-key "eshell")

    ;; Search
    "s" '(:ignore t :which-key "search")
    "sb" '(:ignore t :which-key "buffers")
    "sbb" '(consult-buffer :which-key "open here")
    "sbw" '(consult-buffer-other-window :which-key "open on other window")
    "sbt" '(consult-buffer-other-tab :which-key "open on another tab")
    "sl" '(consult-line :which-key "lines")
    "sL" '(consult-line-multi :which-key "lines all files")
    "sg" '(consult-grep :which-key "words")
    "st" '(consult-theme :which-key "theme")
    "sm" '(consult-mark :which-key "marks")
    "sq" '(consult-kmacro :which-key "macros")
    "sf" '(consult-fd :which-key "open here")

    "t" '(:ignore t :which-key "tab")
    "tn" '(tab-new :which-key "new")
    "tt" '(evil-tab-next :which-key "next")
    "tp" '(tab-previous :which-key "previous")
    "tr" '(tab-rename :which-key "rename")
    "tc" '(tab-close :which-key "close")
    "tC" '(tab-close-other :which-key "close others")
    "tg" '(tab-group :which-key "group")
    "tf" '(ffap-other-tab :which-key "open file on another tab")
    "tD" '(tab-detach :which-key "detach")

    "h" '(:ignore t :which-key "help")
    "hv" '(describe-variable :which-key "variable")
    "hf" '(describe-function :which-key "function")
    "hk" '(describe-key :which-key "keybind")
    "hx" '(describe-command :which-key "command")
    "hp" '(describe-package :which-key "package")
    "hn" '(view-emacs-news :which-key "news")

    "g" '(:ignore t :which-key "git")
    "gg" '(magit :which-key "magit")
    "gc" '(magit-commit :which-key "commit")
    "gi" '(magit-init :which-key "init")
    "gl" '(magit-log :which-key "log")

    "x" '(:ignore t :which-key "commands")
    ;; Narrow
    "xn" '(:ignore t :which-key "narrow")
    "xnn" '(narrow-to-region :which-key "narrow to region")
    "xnw" '(widen :which-key "widen view")
    "xnp" '(narrow-to-page :which-key "narrow to page")
    "xnd" '(narrow-to-defun :which-key "narrow to defun")
    ;; Toggle
    "xt" '(:ignore t :which-key "toggle")
    "xtc" '(display-fill-column-indicator-mode :which-key "clmn. limit")
    "xtn" '(display-line-numbers-mode :which-key "line numbers")
    "xtz" '(writeroom-mode :which-key "writeroom mode")
    "xtt" '(ef-themes-toggle :which-key "toggle dark/light themes")
    ;; Session
    "xs" '(:ignore t :which-key "session")
    "xss" '(desktop-save :which-key "save")
    "xsr" '(desktop-read :which-key "load")

    ;; "n" '(:ignore t :which-key "notes")
    ;; "nn"'(denote :which-key "new note")
    ;; "ns"'(consult-notes :which-key "search note")
    ;; "nl"'(denote-link :which-key "create link")
    ;; "nk"'(denote-keywords-add :which-key "create link")

    "q" '(:ignore t :which-key "emacs")
    "qx" '(kill-emacs :which-key "kill emacs")
    "qX" '(save-buffers-kill-emacs :which-key "save buffers and exit")
    "qt" '(emacs-uptime :which-key "uptime")
    "qv" '(emacs-version :which-key "version")
    "qA" '(about-emacs :which-key "about"))
  

  (general-create-definer rc/local-leader-keys
    :states '(normal visual emacs)
    :prefix "¿"
    )

  (rc/local-leader-keys LaTeX-mode-map
    :states '(normal visual emacs insert)
   "v" '(TeX-view :which-key "View PDF file")
   "e" '(LaTeX-environment :which-key "Insert environment")
   "m" '(TeX-insert-macro :which-key "Insert macro")
   "s" '(LaTeX-section :which-key "Insert section")
   "_" '(TeX-master-file-ask :which-key "Define master file")
   "a" '(TeX-command-run-all :which-key "Compile all files")
   "t" '(reftex-toc :which-key "Open TOC")
   "i" '(reftex-index :which-key "Insert index command")
   "f" '(:ignore t :which-key "fold")
   "fe" '(TeX-fold-env :which-key "Fold environment")
   "ff" '(TeX-fold-dwim :which-key "Fold dwim")
   "fb" '(TeX-fold-buffer :which-key "Fold complete buffer")
   "fB" '(TeX-fold-clearout-buffer :which-key "Undo folds on buffer")
   "fr" '(TeX-fold-region :which-key "Fold region")
   "fR" '(TeX-fold-clearout-region :which-key "Fold region")
   "fm" '(TeX-fold-macro :which-key "Fold macro")
   "ne" '(LaTeX-narrow-to-environment :which-key "Narrow to environment")
   "ng" '(TeX-narrow-to-group :which-key "Narrow to group"))

  ;; ;; LaTeX mode keybinds
  ;; (general-create-definer rc/leader-latex
  ;;   :states '(normal visual emacs)
  ;;   :keymaps 'LaTeX-mode-map
  ;;   :prefix "SPC"
  ;;   )

  (general-define-key
   :keymaps 'override
   "<f6>" 'toggle-menu-bar-mode-from-frame)

  (general-define-key
   :keymaps 'LaTeX-mode-map
   "C-<return>" 'LaTeX-insert-item)

  ;; (rc/leader-latex
  ;;  "m" '(:ignore t :which-key "latex")
  ;;  "mv" '(TeX-view :which-key "View PDF file")
  ;;  "me" '(LaTeX-environment :which-key "Insert environment")
  ;;  "mm" '(TeX-insert-macro :which-key "Insert macro")
  ;;  "ms" '(LaTeX-section :which-key "Insert section")
  ;;  "m_" '(TeX-master-file-ask :which-key "Define master file")
  ;;  "ma" '(TeX-command-run-all :which-key "Compile all files")
  ;;  "mt" '(reftex-toc :which-key "Open TOC")
  ;;  "mi" '(reftex-index :which-key "Insert index command")
  ;;  "mf" '(:ignore t :which-key "fold")
  ;;  "mfe" '(TeX-fold-env :which-key "Fold environment")
  ;;  "mff" '(TeX-fold-dwim :which-key "Fold dwim")
  ;;  "mfb" '(TeX-fold-buffer :which-key "Fold complete buffer")
  ;;  "mfB" '(TeX-fold-clearout-buffer :which-key "Undo folds on buffer")
  ;;  "mfr" '(TeX-fold-region :which-key "Fold region")
  ;;  "mfR" '(TeX-fold-clearout-region :which-key "Fold region")
  ;;  "mfm" '(TeX-fold-macro :which-key "Fold macro")
  ;;  "xne" '(LaTeX-narrow-to-environment :which-key "Narrow to environment")
  ;;  "xng" '(TeX-narrow-to-group :which-key "Narrow to group"))
  )

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :custom
  (evil-undo-system 'undo-redo) 
  :config
  (evil-mode 1)
  (define-key
   evil-insert-state-map (kbd "C-g")
   'evil-normal-state)
  (define-key
   evil-insert-state-map (kbd "C-h")
   'evil-delete-backward-char-and-join)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  ;;(evil-set-initial-state 'elfeed-search-mode 'normal)
  ;;(evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'emacs)
  ;; (eval-after-load 'evil-maps
  ;;   '(progn
  ;;      (global-unset-key (kbd "SPC"))))
  ;;   (evil-define-key 'normal org-mode-map (kbd "<return>")
  ;;     '+org/dwim-at-point)
  ;;  (evil-define-key '(normal insert) org-mode-map (kbd "C-<return>")
  ;;     '+org/insert-item-below)
  ;;  (evil-define-key '(normal insert) org-mode-map (kbd "M-<return>")
  ;;     '+org/insert-item-above)
  )


;; (use-package evil-traces
;;   :init
;;   (evil-traces-mode)
;;   :custom-face
;;   (evil-ex-substitute-matches ((t (:inherit diff-removed
;;                                             :foreground unspecified
;;                                             :background unspecified))))
;;   (evil-ex-substitute-replacement ((t (:inherit diff-added
;;                                                 :foreground unspecified
;;                                                 :background unspecified))))
;;   (evil-traces-change ((t (:inherit diff-removed))))
;;   (evil-traces-copy-preview ((t (:inherit diff-added))))
;;   (evil-traces-copy-range ((t (:inherit diff-changed))))
;;   (evil-traces-delete ((t (:inherit diff-removed))))
;;   (evil-traces-global-match ((t (:inherit diff-added))))
;;   (evil-traces-global-range ((t (:inherit diff-changed))))
;;   (evil-traces-join-indicator ((t (:inherit diff-added))) t)
;;   (evil-traces-join-range ((t (:inherit diff-changed))))
;;   (evil-traces-move-preview ((t (:inherit diff-added))))
;;   (evil-traces-move-range ((t (:inherit diff-removed))))
;;   (evil-traces-normal ((t (:inherit diff-changed))))
;;   (evil-traces-shell-command ((t (:inherit diff-changed))))
;;   (evil-traces-substitute-range ((t (:inherit diff-changed))))
;;   (evil-traces-yank ((t (:inherit diff-changed))))
;;   )
;; 
;; (use-package evil-lion 
;;   :config
;;   (evil-lion-mode))
;; 
;; (use-package evil-nerd-commenter
;;   :config
;;   (evilnc-default-hotkeys nil t))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; (use-package evil-adjust
;;   :elpaca (evil-adjust :type git :host github :repo "troyp/evil-adjust")
;;   :after evil
;;   :config
;;   (require 'evil-adjust)
;;   (evil-adjust))
