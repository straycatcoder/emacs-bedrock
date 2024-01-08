;; online packages: AI and Social

;; mastodon social
;; https://codeberg.org/martianh/mastodon.el
(use-package mastodon
  :ensure t
  :config
  (setq mastodon-instance-url "https://mastodon.social"
        mastodon-active-user "cyberpoker98"
        mastodon-toot-display-orig-in-reply-buffer t))

;; markdown mode for gptel
;; https://jblevins.org/projects/markdown-mode/
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

;; gptel
;; https://github.com/karthink/gptel
(use-package gptel
  :ensure t)
;; it seems chatgpt api is not free any more

