;;; Emacs Bedrock
;;;
;;; Extra config: Org-mode starter config

;;; Usage: Append or require this file from init.el for some software
;;; development-focused packages.
;;;
;;; Org-mode is a fantastically powerful package. It does a lot of things, which
;;; makes it a little difficult to understand at first.
;;;
;;; We will configure Org-mode in phases. Work with each phase as you are
;;; comfortable.
;;;
;;; YOU NEED TO CONFIGURE SOME VARIABLES! The most important variable is the
;;; `org-directory', which tells org-mode where to look to find your agenda
;;; files.

;;; See "org-intro.txt" for a high-level overview.

;;; Contents:
;;;
;;;  - Critical variables
;;;  - Phase 1: editing and exporting files
;;;  - Phase 2: todos, agenda generation, and task tracking
;;;  - Phase 3: extensions (org-roam, etc.)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Critical variables
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; These variables need to be set for Org-mode's full power to be unlocked!
;;;
;;; You can read the documentation for any variable with `C-h v'. If you have
;;; Consult configured (see the `base.el' file) then it should help you find
;;; what you're looking for.

;;; Phase 1 variables

;;; Phase 2 variables

;; Agenda variables
(setq org-directory "~/Documents/Dropbox/Orgfiles/agenda") ; Non-absolute paths for agenda and
                                        ; capture templates will look here.
(setq org-default-notes-file "inbox.org")

(setq org-agenda-files '("inbox.org" "work.org" "personal.org"))

;; Default tags
(setq org-tag-alist '(
                      ;; locale
                      (:startgroup)
                      ("home" . ?h)
                      ("work" . ?w)
                      ("school" . ?s)
                      (:endgroup)
                      (:newline)
                      ;; scale
                      (:startgroup)
                      ("one-shot" . ?o)
                      ("project" . ?j)
                      ("tiny" . ?t)
                      (:endgroup)
                      ;; misc
                      ("meta")
                      ("review")
                      ("reading")))

;; Org-refile: where should org-refile look?
(setq org-refile-targets 'FIXME)

;;; Phase 3 variables

;; Org-roam variables
;; (setq org-roam-directory "~/Documents/org-roam/")
;; (setq org-roam-index-file "~/Documents/org-roam/index.org")

;;; Optional variables

;; Advanced: Custom link types
;; This example is for linking a person's 7-character ID to their page on the
;; free genealogy website Family Search.
;; (setq org-link-abbrev-alist
;;       '(("family_search" . "https://www.familysearch.org/tree/person/details/%s")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Phase 1: editing and exporting files
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org
  :hook ((org-mode . visual-line-mode)  ; wrap lines at word breaks
         (org-mode . flyspell-mode))    ; spell checking!

  :bind (:map global-map
              ("C-c l" . org-store-link)          ; Mnemonic: link → store
              ("C-c a" . org-agenda) ; open agenda
              ("C-c c" . org-capture)) ; org-capture

  :config
  (setq org-support-shift-select 'always)
  (setq org-adapt-indentation t)
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-log-into-drawer t)
  (setq org-blank-before-new-entry '((heading . t) (plain-list-item . auto)))  ;; add a blank line 
  (require 'oc-csl)                     ; citation support
  (add-to-list 'org-export-backends 'md)

  ;; Make org-open-at-point follow file links in the same window
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)

  ;; Make exporting quotes better
  (setq org-export-with-smart-quotes t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Phase 2: todos, agenda generation, and task tracking
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Yes, you can have multiple use-package declarations. It's best if their
;; configs don't overlap. Once you've reached Phase 2, I'd recommend merging the
;; config from Phase 1. I've broken it up here for the sake of clarity.
(use-package org
  :config
  ;; Instead of just two states (TODO, DONE) we set up a few different states
  ;; that a task can be in.
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAITING(w@/!)" "ONGOING(o!)" "HOLD(h@/i)" "|" "DONE(d!)" "CANCELLED(o@)")))
  ;; set keyword color
  (setq org-todo-keyword-faces
      (quote (;("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("ONGOING" :foreground "lime green" :weight bold)
              ;("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ;("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))


  ;; Refile configuration
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path 'file)

  (setq org-capture-templates
        '(("c" "Default Capture" entry (file "inbox.org")
           "* TODO %?\n%U\n%i")
          ;; Capture and keep an org-link to the thing we're currently working with
          ("r" "Capture with Reference" entry (file "inbox.org")
           "* TODO %? %^G")
          ;; Define a section
          ("w" "Work")
          ("wp" "Work projects" entry (file+headline "work.org" "Projects")
           "** TODO %^{to-do} %^g")          
          ("wm" "Work meeting" entry (file+headline "work.org" "Meetings")
           "** TODO %^{meeting} %^g")
          ("wm" "Work admin task" entry (file+headline "work.org" "Administrative Tasks")
           "** TODO %^{admin_task}")
          ("wr" "Work report" entry (file+headline "work.org" "Reports")
           "** TODO %^{report} %^g")
        ;; Define a section
        ("p" "Personal")
          ("pr" "Reading" entry (file+headline "personal.org" "Reading")
           "** TODO %^{to-do} %^g")
          ("ph" "Hobby" entry (file+headline "personal.org" "Hobby")
           "** TODO %^{to-do} %^g")
          ("pw" "Writing" entry (file+headline "personal.org" "Writing")
           "** TODO %^{to-do} %^g")
          ("po" "Others" entry (file+headline "personal.org" "Others")
           "** TODO %^{to-do} %^g")
          ("pc" "Coding" entry (file+headline "personal.org" "Coding")
           "** TODO %^{to-do} %^g")
        ))

    (setq org-agenda-custom-commands
          '(
            ("n" "Agenda and All Todos"  ((agenda) (todo)))
            ("w" "Work" agenda "" ((org-agenda-files '("work.org"))))
            ("p" "Personal" agenda "" ((org-agenda-files '("personal.org"))))
            ("r" "Next 10 days" ((agenda "" ((org-agenda-span 10)
                                             (org-agenda-start-day "0d")
                                              (org-agenda-start-on-weekday nil)))))
            )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Phase 3: extensions (org-roam, etc.)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package org-roam
;;   :ensure t
;;   :config
;;   (org-roam-db-autosync-mode)
;;   ;; Dedicated side window for backlinks
;;   (add-to-list 'display-buffer-alist
;;                '("\\*org-roam\\*"
;;                  (display-buffer-in-side-window)
;;                  (side . right)
;;                  (window-width . 0.4)
;;                  (window-height . fit-window-to-buffer))))

;; Pretty web interface for org-roam
;(use-package org-roam-ui
;  :ensure t
;  :after org-roam
;  :config
;  (setq org-roam-ui-sync-theme t
;        org-roam-ui-follow t
;        org-roam-ui-update-on-save t
;        org-roam-ui-open-on-start t))

;; denote
(use-package denote
  :ensure t
  :bind
  ("C-c n n" . 'denote)
  :init
  (setq denote-directory "~/Documents/Dropbox/Orgfiles/notes")
  :config
  (setq denote-known-keywords '("emacs","stocks"))
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  (setq denote-file-type nil) ; Org is the default, set others here
  (setq denote-prompts '(subdirectory title keywords)))
