;; online packages: AI and Social

;; mastodon social
;; https://codeberg.org/martianh/mastodon.el
(use-package mastodon
  :ensure t
  :config
  (setq mastodon-instance-url "https://mastodon.social"
        mastodon-active-user "cyberpoker98"
        mastodon-toot-display-orig-in-reply-buffer t))

;; https://jblevins.org/projects/markdown-mode/
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

;; https://github.com/s-kostyaev/ellama
(use-package ellama
  :init
  (setq ellama-auto-scroll t))

(require 'llm-ollama)
    (setopt ellama-provider
		  (make-llm-ollama
		   :chat-model "solar" :embedding-model "solar"))
