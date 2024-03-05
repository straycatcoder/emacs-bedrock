
;; set up default font
(if (x-list-fonts "Monaco")
    (set-frame-font "Monaco 14" nil t)
  (set-frame-font "RobotoMono Nerd Font 14" nil t))
  

;; Modus themes
;; https://protesilaos.com/emacs/modus-themes
;;; For packaged versions which must use `require'.
(use-package modus-themes
  :ensure t
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)
  ;; set which themes to toggle
  (setq modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))

  ;; Maybe define some palette overrides, such as by using our presets

  ;; Load the theme of your choice.
  (load-theme 'modus-operandi-tinted :no-confirm)

  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

;; need to install the font: M-x nerd-icons-install-fonts
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-buffer-modification-icon nil)
  (setq doom-modeline-buffer-file-name-style 'relative-from-project)
  (doom-modeline-def-modeline 'my-simple-line
    '(time matches buffer-info remote-host buffer-position selection-info)
    '(misc-info minor-modes input-method process vcs checker major-mode))
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'my-simple-line 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline))

