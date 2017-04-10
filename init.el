; list the repositories containing them
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; list the packages you want
(setq package-list '(better-defaults
                     solarized-theme
                     helm
                     helm-projectile
                     helm-ag
                     ruby-electric
                     seeing-is-believing
                     inf-ruby
                     ruby-test-mode))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'better-defaults)

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'ruby-mode)

(load-theme 'solarized-dark t)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "s-f")  #'helm-projectile-ag)
(global-set-key (kbd "s-t") #'helm-projectile-find-file-dwin)

;; show line numbers
:(global-linum-mode)

;; Typography
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 150
                    :weight 'normal
                    :width 'normal)

;; Ignore the visible bell
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; RUBY

;; Rinari && neotree
(add-to-list 'load-path' "/Users/BrunoCosta/.emacs.d/plugins/rinari")
(add-to-list 'load-path' "/Users/BrunoCosta/.emacs.d/plugins/neotree")

(require 'rinari)
(require 'neotree)
(global-set-key [F8] 'neotree-toggle)

;; Autoclose paired syntax elements like parens, quotes, etc
(add-hook 'ruby-mode-hook 'ruby-electric-mode)

(add-to-list 'auto-mode-alist
             '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;; seeing is believing
(setq seeing-is-believing-prefix "C-.")
(add-hook 'ruby-mode-hook 'seeing-is-believing)
(require 'seeing-is-believing)

;; inf-ruby
(autoload 'inf-ruby-minor-mode "inf-ruby" "Run as inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

;; ruby TDD
(require 'ruby-test-mode)
(add-hook 'ruby-mode-hook 'ruby-test-mode)

(add-hook 'compilation-finish-functions
          (lambda (buf strg)
            (switch-to-buffer-other-window "*compilation*")
            (read-only-mode)
            (goto-char (point-max))
            (local-set-key (kbd "q")
                           (lambda () (interactive) (quit-restore-window)))))


(setq ns-right-alternate-modifier nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (flycheck seeing-is-believing better-defaults))))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
