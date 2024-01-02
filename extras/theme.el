
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
  (setq modus-themes-to-toggle '(modus-operandi-tritanopia modus-vivendi-tritanopia))

  ;; Maybe define some palette overrides, such as by using our presets

  ;; Load the theme of your choice.
  (load-theme 'modus-operandi-tritanopia :no-confirm)

  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))
