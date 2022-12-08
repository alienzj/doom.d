;;; private/calendar/init.el -*- lexical-binding: t; -*-

;; method 1
;(require 'oauth2-auto)
;(setq oauth2-auto-google-client-id "[REDACTED]"
;      oauth2-auto-google-client-secret "[REDACTED]")

;(use-package! oauth2-auto
;  (setq oauth2-auto-google-client-id "2984827057-7t7cajanvei2d2fhada3c2rf6ka8j6cv.apps.googleusercontent.com"
;        oauth2-auto-google-client-secret "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"))

;(use-package! oauth2-auto
;  (setq oauth2-auto-google-client-id "alienchuj@gmail.com"
;        oauth2-auto-google-client-secret "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"))


;(defun org-gcal--get-access-token ()
;  (oauth2-auto-access-token-sync "alienchuj@gmail.com" 'google))



;; method 2
(require 'org-gcal)
(setq org-gcal-client-id "2984827057-7t7cajanvei2d2fhada3c2rf6ka8j6cv.apps.googleusercontent.com"
      org-gcal-client-secret "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"
      org-gcal-fetch-file-alist '(("alienchuj@gmail.com" . "~/documents/doraemon/org/calendar.org")))


(defun jack-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Green")  ; org-agenda source
    (cfw:org-create-file-source "Google Cal" "~/documents/doraemon/org/calendar.org" "Purple")  ; other org source
    ;(cfw:org-create-file-source "Google Cal" "~/documents/doraemon/org/calendar.org" "Cyan")  ; other org source
    ;(cfw:howm-create-source "Blue")  ; howm source
    ;(cfw:cal-create-source "Orange") ; diary source
    ;(cfw:ical-create-source "Moon" "~/moon.ics" "Gray")  ; ICS source1
    ;(cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; google calendar ICS
)))
