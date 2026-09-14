;;; helix-custom-theme.el --- A custom theme ported from Helix -*- lexical-binding: t -*-

(deftheme helix-custom "A custom dark theme ported from Helix.")

(let ((white      "#ffffff")
      (lilac      "#dbbfef")
      (lavender   "#a4a0e8")
      (comet      "#5a5977")
      (bossanova  "#452859")
      (midnight   "#3b224c")
      (revolver   "#281733")
      (silver     "#cccccc")
      (sirocco    "#697C81")
      (mint       "#9ff28f")
      (almond     "#eccdba")
      (chamois    "#E8DCA0")
      (honey      "#efba5d")
      (apricot    "#f47868")
      (lightning  "#ffcd1c")
      (delta      "#6F44F0")
      ;; Custom UI colors from your config
      (true-bg    "#1b1818")
      (sel-bg     "#540099")
      (match-bg   "#6C6999")
      (frame-bg   "#634450"))

  (custom-theme-set-faces
   'helix-custom

   ;; ---- UI / Base ----
   ;; `(default ((t (:background ,midnight :foreground ,white))))
   `(default ((t (:background ,midnight :foreground ,white))))
   `(cursor ((t (:background ,white :foreground ,midnight))))
   `(region ((t (:background ,sel-bg))))
   `(hl-line ((t (:background ,bossanova))))
   `(fringe ((t (:background ,midnight :foreground ,comet))))
   `(vertical-border ((t (:foreground ,comet))))
   `(window-divider ((t (:foreground ,comet))))
   `(minibuffer-prompt ((t (:foreground ,lilac :weight bold))))

   ;; Mode Line
   `(mode-line ((t (:background ,revolver :foreground ,lilac :box nil))))
   `(mode-line-inactive ((t (:background ,revolver :foreground ,lavender :box nil))))

   ;; Line Numbers
   `(line-number ((t (:foreground ,comet))))
   `(line-number-current-line ((t (:foreground ,lilac :weight bold))))

   ;; Search / Match
   `(isearch ((t (:background ,match-bg :foreground ,white))))
   `(lazy-highlight ((t (:background ,bossanova :foreground ,white))))

   ;; ---- SYNTAX (Font Lock) ----
   `(font-lock-keyword-face ((t (:foreground ,almond :weight bold :slant italic))))
   `(font-lock-function-name-face ((t (:foreground ,mint))))
   `(font-lock-variable-name-face ((t (:foreground ,lavender))))
   `(font-lock-type-face ((t (:foreground ,white))))
   `(font-lock-constant-face ((t (:foreground ,white))))
   `(font-lock-string-face ((t (:foreground ,mint))))
   `(font-lock-comment-face ((t (:foreground ,sirocco :slant italic))))
   `(font-lock-builtin-face ((t (:foreground ,mint))))
   `(font-lock-preprocessor-face ((t (:foreground ,lilac :slant italic))))
   `(font-lock-warning-face ((t (:foreground ,lightning))))
   `(font-lock-doc-face ((t (:foreground ,sirocco :slant italic))))

   ;; Extra syntax faces (primarily utilized by tree-sitter / Emacs 29+)
   `(font-lock-punctuation-face ((t (:foreground ,lavender))))
   `(font-lock-operator-face ((t (:foreground ,lilac))))
   `(font-lock-number-face ((t (:foreground ,chamois))))
   `(font-lock-escape-face ((t (:foreground ,honey))))
   `(font-lock-regexp-face ((t (:foreground ,honey))))
   `(font-lock-property-name-face ((t (:foreground ,white))))

   ;; ---- MARKUP (Org / Markdown) ----
   `(org-level-1 ((t (:foreground ,mint :weight bold))))
   `(org-level-2 ((t (:foreground ,mint :weight bold))))
   `(org-level-3 ((t (:foreground ,mint :weight bold))))
   `(org-level-4 ((t (:foreground ,mint :weight bold))))
   `(org-link ((t (:foreground ,silver :underline t))))
   `(org-quote ((t (:foreground ,sirocco :slant italic))))
   `(org-code ((t (:foreground ,honey))))
   `(org-document-title ((t (:foreground ,mint :weight bold))))
   `(markdown-header-face ((t (:foreground ,mint :weight bold))))
   `(markdown-code-face ((t (:foreground ,honey))))

   ;; ---- DIAGNOSTICS (Flycheck / Flymake) ----
   `(flymake-error ((t (:underline (:color ,apricot :style wave)))))
   `(flymake-warning ((t (:underline (:color ,lightning :style wave)))))
   `(flymake-note ((t (:underline (:color ,delta :style wave)))))
   `(flycheck-error ((t (:underline (:color ,apricot :style wave)))))
   `(flycheck-warning ((t (:underline (:color ,lightning :style wave)))))
   `(flycheck-info ((t (:underline (:color ,delta :style wave)))))

   ;; ---- DIFF / MAGIT ----
   `(diff-added ((t (:foreground ,mint))))
   `(diff-removed ((t (:foreground ,apricot))))
   `(diff-changed ((t (:foreground ,delta))))
   `(diff-indicator-added ((t (:foreground ,mint :weight bold))))
   `(diff-indicator-removed ((t (:foreground ,apricot :weight bold))))
   `(magit-diff-added ((t (:foreground ,mint))))
   `(magit-diff-removed ((t (:foreground ,apricot))))
   `(magit-diff-context ((t (:foreground ,sirocco))))
   `(magit-diff-added-highlight ((t (:background ,frame-bg :foreground ,mint))))
   `(magit-diff-removed-highlight ((t (:background ,frame-bg :foreground ,apricot))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'helix-custom)

;;; helix-custom-theme.el ends here
