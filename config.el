;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq font-size
      (let ((host (system-name)))
        (cond
         ((string= host "ArchBeauty") 40)
         ((string= host "ArchBeasty") 38)
         (t 24))))

(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font"
                            :size font-size :weight 'normal)) ;;'semi-light))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme
      (let ((host (system-name)))
        (cond
         ((string= host "gate") 'doom-opera)
         (t 'doom-one))))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org-roam/")
(after! org
  (setq org-agenda-files `(,(expand-file-name "~/org-roam")
                           ,(expand-file-name "~/org-roam/daily")))
  (setq
   org-latex-images-centered nil
   )
  (org-add-link-type
   "color" nil
   (lambda (path desc format)
     (cond
      ((eq format 'html)
       (format "<span style=\"color:%s;\">%s</span>" path desc))
      ((eq format 'latex)
       (format "{\\color{%s}%s}" path desc))))))

(map! "C-S-o" #'evil-window-right
      "C-S-n" #'evil-window-left
      "C-S-i" #'evil-window-up
      "C-S-e" #'evil-window-down)

(after! org-journal
  (setq org-journal-dir "~/org-roam/daily"
        org-journal-carryover-items ""
        org-journal-time-prefix "** "
        org-journal-date-prefix "* "
        org-journal-date-format "%A, %x"
        org-journal-time-format " "
        org-journal-file-type 'weekly
        org-journal-file-format "%Y_%m_%d.org"))

(map! :localleader
      (:map org-mode-map
       "B" (lambda () (interactive) (org-beamer-export-to-pdf))))

(map! (:map pdf-view-mode-map
            "e" #'pdf-view-next-line-or-next-page
            "i" #'pdf-view-previous-line-or-previous-page))
(after! pdf-tools
  (evil-define-key* 'normal pdf-view-mode-map "e" #'pdf-view-next-line-or-next-page)
  (evil-define-key* 'normal pdf-view-mode-map "i" #'pdf-view-previous-line-or-previous-page))

(use-package! code-cells)

(after! org
  (add-hook 'org-agenda-mode-hook #'turn-off-evil-mode nil))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
