(use-package lsp-java
  :config
  (require 'lsp-java-boot)
  (add-hook 'java-mode-hook #'lsp)
  (add-hook 'lsp-mode-hook #'lsp-lens-mode)
  (add-hook 'lsp-mode-hook #'lsp-inlay-hints-mode)
  (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)
  )

(use-package lsp-mode
  :custom
  (lsp-enable-snippet t))

(use-package flycheck
  :custom
  (global-flycheck-mode))

(use-package lsp-ui
  :config
  (lsp-ui-doc-enable t))
