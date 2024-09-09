(use-package howm
  :ensure t
  :config
  (setq howm-home-directory "~/Documents/Dropbox/Orgfiles/howm/")
  (setq howm-directory "~/Documents/Dropbox/Orgfiles/howm/")
  (setq howm-keyword-file (expand-file-name ".howm-keys" howm-home-directory))
  (setq howm-history-file (expand-file-name ".howm-history" howm-home-directory))
  ;(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.md")
)
