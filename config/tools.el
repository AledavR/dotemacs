;; (use-package eat
;;   :elpaca (emacs-eat :type git
;; 		     :host codeberg
;; 		     :repo "akib/emacs-eat"))

(use-package org-sliced-images
  :elpaca (org-sliced-images :type git
  :host github
  :repo "jcfk/org-sliced-images")
  :config
  (defalias 'org-remove-inline-images #'org-sliced-images-remove-inline-images)
  (defalias 'org-toggle-inline-images #'org-sliced-images-toggle-inline-images)
  (defalias 'org-display-inline-images #'org-sliced-images-display-inline-images))
