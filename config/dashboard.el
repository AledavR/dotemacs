(defun my-inhibit-startup-screen-file ()
  "Startup screen inhibitor for `command-line-functions`.
Inhibits startup screen on the first unrecognised option which
names an existing file."
  (ignore
   (setq inhibit-startup-screen
	 (file-exists-p
	  (expand-file-name argi command-line-default-directory)))))

(add-hook 'command-line-functions #'my-inhibit-startup-screen-file)

(use-package dashboard
  :elpaca t
  :preface
  (defun protect-dashboard ()
    (define-key dashboard-mode-map (kbd "q") 'dashboard-refresh-buffer)
    )
  (defun rc/dashboard-keymaps ()
    (general-define-key
     :keymaps 'dashboard-mode-map
     :states '(normal emacs)
     "f" 'find-file
     "r" 'consult-recent-file
     "a" 'org-agenda
     "c" 'org-capture
     "p" 'project-switch-project))
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (add-hook 'dashboard-mode-hook 'protect-dashboard)
  (add-hook 'dashboard-mode-hook 'rc/dashboard-keymaps)
  (add-hook 'dashboard-after-initialize-hook 'dashboard-refresh-buffer)
  (setq
   dashboard-center-content t
   dashboard-display-icons-p t
   dashboard-icon-type 'nerd-icons
   dashboard-items nil
   dashboard-set-file-icons t
   dashboard-set-navigator t
   dashboard-set-init-info t
   dashboard-startup-banner (concat user-emacs-directory "marivector.png")
   dashboard-banner-logo-title "(E)ditor Macros"
   dashboard-image-banner-max-height 550
   dashboard-banner-logo-title nil)
  :init
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))
