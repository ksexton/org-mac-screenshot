;; * org-mac-screenshot.el --- Take screenshots on Mac OS X
;;   :PROPERTIES:
;;   :copyright: Kyle Sexton
;;   :copyright-years: 2013
;;   :version:  0.1
;;   :licence:  GPL 2 or later (free software)
;;   :licence-url: http://www.gnu.org/licenses/
;;   :part-of-emacs: no
;;   :authors: Kyle Sexton
;;   :author_email: ks@mocker.org
;;   :credits:  Derek Feichtinger <derek.feichtinger@psi.ch>
;;   :inspiration: org-screenshot
;;   :keywords: emacs screenshots darwin mac
;;   :git-repo: https://github.com/tj64/outshine.git
;;   :git-clone: git://github.com/tj64/outshine.git
;;   :END:

;; ** Commentary
;; The current version of org-screenshot.el is dependent on imagemagick
;; which doesn't work great on Mac OS X systems.  This is a stripped down
;; version that makes assumptions about where to place screenshots and
;; uses the built in screenshot tool.

;; * Defuns
;; ** Functions
;; *** Take screenshot

;; Adapted from org-screenshot.el
(defun org-mac-screenshot (prfx)
  (interactive "P")
  (setq filename (concat (buffer-name) (format-time-string "-screenshot-%Y%m%d-%H%M%S-%4N.png")))
  (let ((scrfilename (concat (file-name-as-directory
			      (org-mac-screenshot-get-attach-dir))
			     filename)))
    (unless prfx (make-frame-invisible nil t))
    (call-process "/usr/sbin/screencapture" nil nil nil "-i" scrfilename)
    (unless prfx (make-frame-visible))
    (when (equal major-mode 'org-mode)
      (insert (concat "[[file:" scrfilename "]]"))
      (org-display-inline-images nil t)
      )))

;; *** Find out where to place screenshot

;; Adapted from org-screenshot.el
(defun org-mac-screenshot-get-attach-dir ()
  org-attach-directory)

;; * Provides
(provide 'org-mac-screenshot)

;; org-mac-screenshot.el
