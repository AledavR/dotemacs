(TeX-add-style-hook
 "beamer"
 (lambda ()
   (LaTeX-add-environments
    '("newframe" LaTeX-env-item)
    '("framenew" LaTeX-env-item))
   (TeX-add-symbols
    '("araaaaa" TeX-arg-color)
    '("aeabeamer" TeX-arg-corner))))

