
;; Org Attach
;;   ___                 _   _   _             _
;;  / _ \ _ __ __ _     / \ | |_| |_ __ _  ___| |__
;; | | | | '__/ _` |   / _ \| __| __/ _` |/ __| '_ \
;; | |_| | | | (_| |  / ___ \ |_| || (_| | (__| | | |
;;  \___/|_|  \__, | /_/   \_\__|\__\__,_|\___|_| |_|
;;            |___/

;; I'm using my own system where attachment links are resolved by moving up the
;; tree in when resolved.
(defun dwarfmaster/attach-list-candidates ()
  "List all attachments available for current heading."
  (save-excursion
    (let ((files '()))
      (outline-back-to-heading)
      (while (not (org-before-first-heading-p))
        (if (and (org-id-get) (file-exists-p (org-attach-dir-from-id (org-id-get))))
            (let* ((dir (org-attach-dir-from-id (org-id-get)))
                   (locals (directory-files dir)))
              (setq files (cl-merge 'list files locals #'string-lessp))))
        (outline-up-heading 1))
      files)))
;; TODO better complete solution for attach links

(defun dwarfmaster/attach-resolve-link (file)
  "Look for FILE in attach directories."
  (save-excursion
    (outline-back-to-heading)
    (let ((path nil))
      (while (and (not path) (not (org-before-first-heading-p)))
        (if (and (org-id-get)
                 (file-exists-p (concat (org-attach-dir-from-id (org-id-get)) "/" file)))
            (setq path (concat (org-attach-dir-from-id (org-id-get)) "/" file)))
        (outline-up-heading 1))
      path)))

(defun dwarfmaster/attach-follow (file &optional arg)
  "Open FILE attachment.
See `org-open-file' for details about ARG"
  (org-link-open-as-file (dwarfmaster/attach-resolve-link file) arg))

(after! org
  (setq org-attach-directory "/data/luc/annex/data")
  (setq org-attach-method 'mv)
  (setq org-attach-auto-tag "attach")
  ;; Stores a link to the file when attaching it
  (setq org-attach-store-link-p t)
  (setq org-attach-archive-delete nil)
  ;; Ask before getting git annexed files
  (setq org-attach-annex-auto-get 'ask)
  ;; Do not commit attachements with git ! Will use a special hook
  (setq org-attach-commit nil))
(after! org-attach
  (org-link-set-parameters "attachment" :follow #'dwarfmaster/attach-follow))
