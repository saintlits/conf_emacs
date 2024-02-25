;; ----------------------------------------------------------------------
;;;                          org-roam
;; ----------------------------------------------------------------------
;;;; Filter nodes
;; https://www.reddit.com/r/emacs/comments/vb989o/orgroam_show_only_file_nodes_when_inserting_a_node/ic8bc7l/?context=3

;;;;; Define regexp for filtering daily journal files like `2022-05-22'
(setq my-date-regexp "^[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} [A-Za-z]+")

;;;;; Define filter functions to be used in `org-roam-node-find' function.
(defun ugt-filter-org-roam-node-file-p (node)
  "Filter nodes that represent files.
So exclude nodes that are outline items in org files.

Usage example:
(org-roam-node-read nil #'ugt-filter-org-roam-node-file-p)
"
  (and
   (= (org-roam-node-level node) 0)
   (not (string-match my-date-regexp (org-roam-node-title node)))))

(defun ugt-filter-org-roam-node-exclude-dates (node)
  "Exclude journal files like `2022-05-17' from nodes list."
  (not (string-match my-date-regexp (org-roam-node-title node))))

(defun ugt-filter-org-roam-node-exclude-archived-and-journal-files (node)
  "Exclude these files / nodes
- tagged `archive'
- in folder `archive'
- journal files."
  (and
   ;; no journal files
   (not (string-match my-date-regexp (org-roam-node-title node)))
   ;; not tagged `archive'
   (not (member "archive" (org-roam-node-tags node)))
   ;; not in any folder named `archive'
   (not (string-match-p "archive/" (org-roam-node-file node)))))

;;;;; Define custom `org-roam-node-find' functions with filters.
(defun ugt-org-roam-node-find nil
  "Refined search for org-roam nodes.
Exclude elements tagged `archive'."
  (interactive)
  ;; nb: can add initial search string like "^"
  (org-roam-node-find :other-window nil #'ugt-filter-org-roam-node-exclude-archived-and-journal-files))

(defun ugt-org-roam-node-find-document-nodes nil
  "Refined search for org-roam nodes.
Search for only document level nodes. Exclude dates."
  (interactive)
  ;;(org-roam-node-find :other-window)
  (org-roam-node-find :other-window nil #'ugt-filter-org-roam-node-file-p))

;;;; Custom `org-roam-dailies-goto-today' function
(defun ugt-org-roam-dailies-goto-today nil
  "Open todays journal in other window."
  (interactive)
  (split-window-right)
  (other-window 1)
  (org-roam-dailies-goto-today))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/ywq_doc/")
  (org-roam-dailies-directory "journals/")
  :bind (("C-c n f" . org-roam-node-find)
         ("M-o" . ugt-org-roam-node-find)
         ("M-O" . ugt-org-roam-node-find-document-nodes)
         ("C-c n r" . org-roam-node-random)
         ("C-c n c" . org-roam-capture)
         ("s-l" . org-roam-buffer-toggle)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today)
         ("s-j" .     org-roam-dailies-capture-today)
         ("C-c n t" . org-roam-dailies-goto-today)
         ("s-t"     . ugt-org-roam-dailies-goto-today)
         ("C-s-["   . org-roam-dailies-goto-previous-note)
         ("C-s-]"   . org-roam-dailies-goto-next-note)
	 (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)
                ("s-i" .     org-roam-node-insert)
                ("M-i" .     org-roam-node-insert) ; new add
                ("C-c n o" . org-id-get-create)
                ("C-c n t" . org-roam-tag-add)
                ("C-c n a" . org-roam-alias-add)
                ("C-c n l" . org-roam-buffer-toggle)
                ("C-c n g" . org-roam-graph))))
  :config
  ;;(org-roam-setup)
  (setq org-roam-node-display-template
        (concat "${title:70}"(propertize "${tags:30}" 'face 'org-tag) "${file:48}"))
  (setq org-roam-capture-templates '(
                                     ("d" "default (personal notes)"
                                      plain "%?"
                                      ;; could use
                                      ;; (file (concat org-directory "/org-roam/personal/templates/personal.org"))
	                              :if-new (file+head "pages/${slug}.org"
                                                         "#+title: ${title}\n#+date: %<%Y-%m-%d %a %R>\n#+startup: showall\n\n")
                                      :immediate-finish t
                                      :empty-lines 1
	                              :unnarrowed t)

                                     ("c" "Contacts"
                                      plain "%?"
                                      :if-new (file+head "pages/contacts/${slug}.org"
                                                         "#+title: ${title}\n#+date: %<%Y-%m-%d %a %R>\n#+filetags: contacts\n#+startup: showall\n\n")
                                      :immediate-finish t
                                      :empty-lines 1
                                      :unnarrowed t)

                                     ("m" "Emacs related notes"
                                      plain "%?"
                                      :if-new (file+head "emacs/${slug}.org"
                                                         "#+title: ${title}\n#+date: %<%Y-%m-%d %a %R>\n#+filetags: emacs\n#+startup: content\n")
                                      :empty-lines 1
                                      :unnarrowed t)

                                     ("w" "work notes"
                                      plain "%?"
                                      :if-new (file+head "work/${slug}.org"
                                                         "#+title: ${title}\n#+date: %<%Y-%m-%d %a %R>\n#+updated: \n\n")
                                      :immediate-finish t
                                      :empty-lines 1
                                      :unnarrowed t))
        time-stamp-start "#\\+updated: [\t]*")
  (setq org-roam-dailies-capture-templates  '(("d" "default" entry
                                                 "\n* %<%H:%M> %?\n:properties:\n:created: %U\n:end:\n"
                                                 :target  (file+head "%<%Y-%m-%d>.org"
                                                                     "#+title: %<%Y-%m-%d>\n#+startup: showall\n")
                                                 ;;:unnarrowed t
                                                 ;;:jump-to-captured t
                                                 :empty-lines 1
                                                 )))
  ;; Change file-name (slug) creation
  ;; Replace whitespace with dashes instead of underscores.
  ;; See
  ;; - https://github.com/org-roam/org-roam/issues/686
  ;; - https://github.com/org-roam/org-roam/pull/1544[[id:2022-06-12T213159.588064][test mest hest]]
  (cl-defmethod org-roam-node-slug ((node org-roam-node))
    "Return the slug of NODE."
    (let ((title (org-roam-node-title node))
          (slug-trim-chars '(;; Combining Diacritical Marks https://www.unicode.org/charts/PDF/U0300.pdf
                             768 ; U+0300 COMBINING GRAVE ACCENT
                             769 ; U+0301 COMBINING ACUTE ACCENT
                             770 ; U+0302 COMBINING CIRCUMFLEX ACCENT
                             771 ; U+0303 COMBINING TILDE
                             772 ; U+0304 COMBINING MACRON
                             774 ; U+0306 COMBINING BREVE
                             775 ; U+0307 COMBINING DOT ABOVE
                             776 ; U+0308 COMBINING DIAERESIS
                             777 ; U+0309 COMBINING HOOK ABOVE
                             778 ; U+030A COMBINING RING ABOVE
                             779 ; U+030B COMBINING DOUBLE ACUTE ACCENT
                             780 ; U+030C COMBINING CARON
                             795 ; U+031B COMBINING HORN
                             803 ; U+0323 COMBINING DOT BELOW
                             804 ; U+0324 COMBINING DIAERESIS BELOW
                             805 ; U+0325 COMBINING RING BELOW
                             807 ; U+0327 COMBINING CEDILLA
                             813 ; U+032D COMBINING CIRCUMFLEX ACCENT BELOW
                             814 ; U+032E COMBINING BREVE BELOW
                             816 ; U+0330 COMBINING TILDE BELOW
                             817 ; U+0331 COMBINING MACRON BELOW
                             )))
      (cl-flet* ((nonspacing-mark-p (char) (memq char slug-trim-chars))
                 (strip-nonspacing-marks (s) (string-glyph-compose
                                              (apply #'string
                                                     (seq-remove #'nonspacing-mark-p
                                                                 (string-glyph-decompose s)))))
                 (cl-replace (title pair) (replace-regexp-in-string (car pair) (cdr pair) title)))
        (let* ((pairs `(("[^[:alnum:][:digit:]]" . "-") ;; convert anything not alphanumeric
                        ("--*" . "-")                   ;; remove sequential underscores
                        ("^-" . "")                     ;; remove starting underscore
                        ("-$" . "")))                   ;; remove ending underscore
               (slug (-reduce-from #'cl-replace (strip-nonspacing-marks title) pairs)))
          (downcase slug)))))
  ;; https://org-roam.discourse.group/t/v2-set-id-to-a-timestamp/1492/2
  ;; (setq org-roam-capture-templates
  ;;       '(("p" "personal" plain
  ;;          (function org-roam--capture-get-point) "%?"
  ;;          :file-name "personal/%<%Y-%m-%dT%H%M%S>"
  ;;          :head "---\ntitle: ${title}\nid: %<%Y-%m-%dT%H%M%S.%6N">\nmodified: <>\n---\n"
  ;;          :unnarrowed t)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))
