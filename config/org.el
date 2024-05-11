;; (add-to-list 'org-structure-template-alist
;;              '("s" "#+NAME: ?\n#+BEGIN_SRC \n\n#+END_SRC"))

(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
(add-hook 'org-babel-after-execute-hook 'org-toggle-inline-images)
