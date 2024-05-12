;; (add-to-list 'org-structure-template-alist
;;              '("s" "#+NAME: ?\n#+BEGIN_SRC \n\n#+END_SRC"))

(use-package org
  :elpaca nil
  :bind ("C-c a" . org-agenda)
  :custom
  (org-todo-keywords '((sequence "IDEA" "TODO" "|" "DONE")))
  (org-agenda-files '("~/Dropbox/org"))
  :config
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)
  (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
  (add-hook 'org-babel-after-execute-hook 'org-toggle-inline-images))

(use-package org-capture
  :ensure nil
  :after org
  :elpaca nil
  :bind ("C-c c" . org-capture)
  :preface
  (defvar my/org-idea-template
    "* IDEA %^{Idea}\n\nCapturado %<%Y-%m-%d %H:%M>"
    "Plantilla básica de ideas.")
  (defvar my/org-idea-template-with-file
    "* IDEA %^{Idea}\n\nCapturado %<%Y-%m-%d %H:%M>\nArchivo: [[%L][%f]]"
    "Plantilla de ideas con archivo.")
  (defvar my/org-basic-task-template
    "* TODO %^{Tarea}\n\nCapturado %<%Y-%m-%d %H:%M>"
    "Plantilla básica de tareas.")
  (defvar my/org-basic-task-template-with-file
    "* TODO %^{Tarea}\n\nCapturado %<%Y-%m-%d %H:%M>\nArchivo: [[%L][%f]]"
    "Plantilla básica de tareas con archivo.")
  (defvar my/org-deadline-task-template
    "* TODO %^{Tarea}\nDEADLINE: %^t\n\nCapturado %<%Y-%m-%d %H:%M>"
    "Plantilla de tareas con fecha limite.")
  (defvar my/org-deadline-task-template-with-file
    "* TODO %^{Tarea}\nDEADLINE: %^t
\nCapturado %<%Y-%m-%d %H:%M>\nArchivo: [[%L][%f]]"
    "Plantilla de tareas con fecha limite y archivo.")
  :custom
  (org-capture-templates
   `(
     ("t" "Tareas")
     ("tt" "Tarea de Universidad" entry
      (file+headline "~/dropbox/org/agenda.org" "Universidad"),
      my/org-basic-task-template
      :empty-lines 1)
     ("tT" "Tarea de Universidad con archivo" entry
      (file+headline "~/dropbox/org/agenda.org" "Universidad"),
      my/org-basic-task-template-with-file
      :empty-lines 1)
     ("tu" "Tarea de Universidad con fecha limite" entry
      (file+headline "~/dropbox/org/agenda.org" "Universidad"),
      my/org-deadline-task-template
      :empty-lines 1)
     ("tU" "Tarea de Universidad con fecha limite y archivo" entry
      (file+headline "~/dropbox/org/agenda.org" "Universidad"),
      my/org-deadline-task-template-with-file
      :empty-lines 1)
     ("tp" "Personal" entry
      (file+headline "~/dropbox/org/agenda.org" "Personal"),
      my/org-basic-task-template
      :empty-lines 1)
     ("tP" "Tarea personal con archivo" entry
      (file+headline "~/dropbox/org/agenda.org" "Personal"),
      my/org-basic-task-template-with-file
      :empty-lines 1)
     ("tl" "Personal con fecha limite" entry
      (file+headline "~/dropbox/org/agenda.org" "Personal"),
      my/org-deadline-task-template
      :empty-lines 1)
     ("tL" "Personal con fecha limite y archivo" entry
      (file+headline "~/dropbox/org/agenda.org" "Personal"),
      my/org-deadline-task-template-with-file
      :empty-lines 1)
     ("i" "Idea" entry
      (file+headline "~/dropbox/org/ideas.org" "Ideas"),
      my/org-idea-template
      :empty-lines 1)
     ("I" "Idea con archivo" entry
      (file+headline "~/dropbox/org/ideas.org" "Ideas"),
      my/org-idea-template-with-file
      :empty-lines 1)
     )))
