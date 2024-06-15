;; (add-to-list 'org-structure-template-alist
;;              '("s" "#+NAME: ?\n#+BEGIN_SRC \n\n#+END_SRC"))

(use-package org
  :elpaca nil
  :bind ("C-c a" . org-agenda)
  :custom
  (org-todo-keywords '((sequence "IDEA" "TODO" "|" "DONE" "DROP")))
  (org-agenda-files '("~/Dropbox/org"))
  (org-log-done 'time)
  (org-highlight-latex-and-related '(latex script entities))
  :config
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)
  (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
  (add-hook 'org-babel-after-execute-hook 'org-toggle-inline-images))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-capture
  :ensure nil
  :after org
  :elpaca nil
  :bind ("C-c c" . org-capture)
  :preface
  ;; (defun rc/idea-to-task (class)
  ;;   (interactive
  ;;    (list (completing-read "Tipo de tarea: " '("Universidad" "Personal"))))
  ;;   (setq agenda-file "~/Dropbox/org/agenda.org")
  ;;   (let ((pos (save-excursion agenda-file class)))
  ;;     (org-refile nil nil (list class nil agenda-file pos))))
  (defvar my/org-agenda-file
    "~/Dropbox/org/agenda.org")
  (defvar my/org-ideas-file
    "~/Dropbox/org/ideas.org")
  (defvar my/org-created-property
    "\n:PROPERTIES:\n:CREATED: [%<%Y-%m-%d %a %H:%M>]\n:END:")
  (defvar my/org-file-link
    "\n\nArchivo: [[%L][%f]]")
  (defvar my/org-idea-template
    (concat "* IDEA %^{Idea}" my/org-created-property)
    "Plantilla básica de ideas.")
  (defvar my/org-idea-template-with-file
    (concat my/org-idea-template my/org-file-link)
    "Plantilla de ideas con archivo.")
  (defvar my/org-basic-task-template
    (concat "* TODO %^{Tarea}" my/org-created-property)
    "Plantilla básica de tareas.")
  (defvar my/org-basic-task-template-with-file
    (concat my/org-basic-task-template my/org-file-link)
    "Plantilla básica de tareas con archivo.")
  (defvar my/org-deadline-task-template
    (concat "* TODO %^{Tarea}\nDEADLINE: %^t" my/org-created-property)
    "Plantilla de tareas con fecha limite.")
  (defvar my/org-deadline-task-template-with-file
    (concat my/org-deadline-task-template my/org-file-link)
    "Plantilla de tareas con fecha limite y archivo.")
  (defun rc/refile-to (file headline)
    "Move current headline to specified location"
    (let ((pos (save-excursion
		 (find-file file)
		 (org-find-exact-headline-in-buffer headline))))
      (org-refile nil nil (list headline file nil pos)))
    (org-save-all-org-buffers)
    (switch-to-buffer (current-buffer)))
  (defun rc/idea-to-task (class)
    "Promotes an idea to a pending task"
    (interactive
     (list (completing-read "Tipo de tarea:" '("Universidad" "Personal"))))
    (org-todo "TODO")
    (rc/refile-to my/org-agenda-file class))
  :custom
  (org-capture-templates
   `(
     ("t" "Tareas")
     ("tt" "Tarea de Universidad" entry
      (file+headline my/org-agenda-file "Universidad"),
      my/org-basic-task-template
      :empty-lines 1)
     ("tT" "Tarea de Universidad con archivo" entry
      (file+headline my/org-agenda-file "Universidad"),
      my/org-basic-task-template-with-file
      :empty-lines 1)
     ("tu" "Tarea de Universidad con fecha limite" entry
      (file+headline my/org-agenda-file "Universidad"),
      my/org-deadline-task-template
      :empty-lines 1)
     ("tU" "Tarea de Universidad con fecha limite y archivo" entry
      (file+headline my/org-agenda-file "Universidad"),
      my/org-deadline-task-template-with-file
      :empty-lines 1)
     ("tp" "Personal" entry
      (file+headline my/org-agenda-file "Personal"),
      my/org-basic-task-template
      :empty-lines 1)
     ("tP" "Tarea personal con archivo" entry
      (file+headline my/org-agenda-file "Personal"),
      my/org-basic-task-template-with-file
      :empty-lines 1)
     ("tl" "Personal con fecha limite" entry
      (file+headline my/org-agenda-file "Personal"),
      my/org-deadline-task-template
      :empty-lines 1)
     ("tL" "Personal con fecha limite y archivo" entry
      (file+headline my/org-agenda-file "Personal"),
      my/org-deadline-task-template-with-file
      :empty-lines 1)
     ("i" "Idea" entry
      (file+headline my/org-ideas-file "Ideas"),
      my/org-idea-template
      :empty-lines 1)
     ("I" "Idea con archivo" entry
      (file+headline my/org-ideas-file "Ideas"),
      my/org-idea-template-with-file
      :empty-lines 1)
     )))
