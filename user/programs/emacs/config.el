
;;; Code:

;;; Basic UI
(map! :leader "b" 'helm-mini)

;;; Figlet
 ;; _____ _       _      _
;; |  ___(_) __ _| | ___| |_
;; | |_  | |/ _` | |/ _ \ __|
;; |  _| | | (_| | |  __/ |_
;; |_|   |_|\__, |_|\___|\__|
         ;; |___/
(defun dwarfmaster/make-figlet-text (b)
  "Interactively query a string from the user, and figletify it. B is a boolean indicating the size."
  (forward-line 1)
  (insert
    (shell-command-to-string
      (concat "figlet" (if b " -f small " " ") (read-string "Figlet: "))))
  )
(defun dwarfmaster/make-figlet-text-normal ()
  "Figletify a queried string."
  (interactive)
  (dwarfmaster/make-figlet-text nil))
(defun dwarfmaster/make-figlet-text-small ()
  "Figletify a queried string with small font."
  (interactive)
  (dwarfmaster/make-figlet-text t))

(map! :leader
      "i g"  'dwarfmaster/make-figlet-text-normal
      "i G"  'dwarfmaster/make-figlet-text-small)

;; Spell checker
;;  ____             _ _    ____ _               _
;; / ___| _ __   ___| | |  / ___| |__   ___  ___| | _____ _ __
;; \___ \| '_ \ / _ \ | | | |   | '_ \ / _ \/ __| |/ / _ \ '__|
;;  ___) | |_) |  __/ | | | |___| | | |  __/ (__|   <  __/ |
;; |____/| .__/ \___|_|_|  \____|_| |_|\___|\___|_|\_\___|_|
;;       |_|
(after! ispell
  (setq ispell-local-dictionary-alist
        '(("en_US"
           "[[:alpha:]]"
           "[^[:alpha:]]"
           "[']"
           t
           ("-d" "en_US,en_CA,en_AU,fr-toutesvariantes")
           nil
           iso-8859-1)))
  (setq ispell-hunspell-dictionary-alist ispell-local-dictionary-alist)
  (setq ispell-dictionary "en_US")
  (setq ispell-personal-dictionary (concat (getenv "XDG_CACHE_HOME") "/hunspell/personal")))

;; Dedukti
;;  ____           _       _    _   _
;; |  _ \  ___  __| |_   _| | _| |_(_)
;; | | | |/ _ \/ _` | | | | |/ / __| |
;; | |_| |  __/ (_| | |_| |   <| |_| |
;; |____/ \___|\__,_|\__,_|_|\_\\__|_|
;;

(use-package! company :after lambdapi-mode)
(use-package! company-math :after lambdapi-mode)
(map! :after lambdapi-mode
      :map lambdapi-mode-map
      :localleader
      "]" #'lp-proof-forward
      "[" #'lp-proof-backward
      "." #'lp-prove-till-cursor
      ";" #'comment-dwim
      "r" #'lambdapi-refresh-window-layout
      (:prefix ("g" . "goto")
       "n" #'lp-jump-proof-forward
       "p" #'lp-jump-proof-backward))
