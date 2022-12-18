;;; org/init.el --- Description -*- lexical-binding: t; -*-


(setq references_bib (concat jack-org-dir "references.bib"))
(setq references_pdf (concat jack-org-dir "pdf_bib/"))
(setq references_pdf_source (concat jack-org-dir "pdf/"))
(setq references_note (concat jack-org-dir "ref/"))

(setq ;org-journal-encrypt-journal t
 org-directory jack-org-dir
 org-agenda-files (list "agenda.org" "projects.org" "inbox.org" "agenda.org" "notes.org")
                                        ;org-ellipsis " ▼ "
                                        ;org-bullets-bullet-list '("#")
 org-download-screenshot-method "flameshot gui --raw > %s"
 org-download-image-dir (concat jack-org-dir "resource/images/"))
