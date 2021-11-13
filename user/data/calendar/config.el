
(load! "+nix")

;; TODO it first starts with requesting GPG password for now reason
(use-package! org-caldav
  :after org
  :config
  (setq org-caldav-url "https://nextcloud.dwarfmaster.net/remote.php/dav/calendars/luc")
  (setq org-caldav-inbox nil)
  (setq org-caldav-sync-direction 'org->cal)
  (setq org-icalendar-timezone "Europe/Paris")
  (setq org-caldav-save-directory (concat *nix/xdg-cache* "emacs"))
  (setq org-caldav-calendars
        '((:calendar-id "dedukteam" :files ("~/wiki/projects/these.org"))))
  ;; Do not include all TODOs
  (setq org-icalendar-include-todo nil)
  ;; Add event for not done scheduled TODOs
  (setq org-icalendar-use-scheduled '(event-if-todo-not-done))
  ;; Add event for deadlines in all TODOs
  (setq org-icalendar-use-deadline '(event-if-todo)))
(map! :after org-caldav :map org-mode-map
      :localleader "S" 'org-caldav-sync)
