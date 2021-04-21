;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Deliessche Maxime"
      user-mail-address "deliessche.maxime@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t) ;; old='t'


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Auto reload of buffers after edited
(global-auto-revert-mode t)
;; Auto reload for non-file buffers such as Dired or Neotree
(setq global-auto-revert-non-file-buffers t)

(defun new-line-bellow-move ()
  (interactive)
  (+evil--insert-newline))

(map! :n "ç" #' new-line-bellow-move)

;;Better key binding for org-mode.
(after! org
  (map! :map org-mode-map
        :n "M-j" #' org-metadown
        :n "M-k" #' org-metaup))

;; Allow to put Emacs in fullscreen on startup.
(if (eq initial-window-system 'x)
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

;; LaTeX function and configs:
(after! latex
  (setq TeX-save-query nil))

(defun TeX-compile ()
  (interactive)
  (save-buffer)
  (TeX-command "LaTeX" 'TeX-master-file -1))

(map! :after latex :map LaTeX-mode-map
      :leader
      :prefix-map ("l" . "LaTeX")
      :desc "Compile" :n "c" #' TeX-compile
      :desc "Compile and display" :n "d" #' TeX-command-run-all
      :desc "Insert section" :n "s" #' LaTeX-section
      :desc "Insert item" :n "i" #' latex-insert-item
      :desc "Insert environment" :n "e" #' LaTeX-environment)

(add-hook 'TeX-mode-hook
  (lambda ()
    (setq TeX-command-extra-options "-shell-escape")
  )
)
;; Magit auto credentials
(setq auth-sources '("~/.authinfo.gpg"))


;; Dired shortcut
(after! dired
  (map! :map dired-mode-map
        :n "°" #' dired-create-empty-file))
