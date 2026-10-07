(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))
(require (prefix-in helix.editor. "helix/editor.scm"))
(require (prefix-in helix.misc. "helix/misc.scm"))
(require "helix/keymaps.scm")
(require (only-in "helix/ext.scm" evalp eval-buffer))
(require-builtin "steel/process" as process.)
(require (prefix-in result. "steel/result"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Helper ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (current-file)
  (helix.static.cx->current-file))

(define (cursor-line)
  (+ 1 (helix.static.get-current-line-number)))

(define (shell-capture cmd args)
  (~> (process.command cmd args)
      (process.with-stdout-piped)
      (process.with-stderr-piped)
      (process.spawn-process)
      (result.unwrap-ok)
      (process.wait->stdout)
      (result.unwrap-ok)))

;;@doc
;; Whether the current working directory is inside a git repository
(define (in-git-repo?)
  (equal? (trim (shell-capture "git" (list "rev-parse" "--is-inside-work-tree"))) "true"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Assemblages ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;@doc
;; move-right > prev-word > next-word > search-selection chained on one keypress
(define (search-word-under-cursor)
  (helix.static.move_char_right)
  (helix.static.move_prev_word_start)
  (helix.static.move_next_word_start)
  (helix.static.search_selection))

;;@doc
;; `:pipe scry`, then collapse the selection back down
(define (scry-pipe)
  (helix.pipe "scry")
  (helix.static.collapse_selection))

;;@doc
;; `:pipe peek <current buffer language>`
(define (peek-pipe)
  (define lang
    (helix.editor.editor-document->language
      (helix.editor.editor->doc-id
        (helix.editor.editor-focus))))
  (helix.pipe "peek" (if (string? lang) lang ""))
  (helix.static.collapse_selection))

;;@doc
;; Jump cwd to the nearest git worktree root
(define (goto-repo-root)
  (helix.change-current-directory (find-workspace)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Odoo ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;@doc
;; Jump cwd to a bookmarked directory: `:go <name>`
(define (go . args)
  (define name (if (null? args) "" (car args)))
  (define bookmarks
    (hash "community" "/home/elco/Dev/odoo/community"
          "web" "/home/elco/Dev/odoo/community/addons/web"
          "api_doc" "/home/elco/Dev/odoo/community/addons/api_doc"
          "mysubscription" "/home/elco/Dev/odoo/community/addons/mysubscription"
          "enterprise" "/home/elco/Dev/odoo/enterprise"
          "web_studio" "/home/elco/Dev/odoo/enterprise/web_studio"
          "odoo" "/home/elco/Dev/odoo"
          "dotfiles" "/home/elco/Dev/dotfiles"))
  (cond [(not (hash-contains? bookmarks name))
         (helix.misc.set-error! (string-append "go: unknown bookmark '" name "'"))]
        [else
         (helix.change-current-directory (hash-get bookmarks name))]))


;; Forced to do this in order to have a `doc` element :/

;;@doc
;; Change CWD to 'api_doc/'
(define (go-api-doc) (go "api_doc"))

;;@doc
;; Change CWD to 'mysubscription/'
(define (go-mysubscription) (go "mysubscription"))

;;@doc
;; Change CWD to 'community/'
(define (go-community) (go "community"))

;;@doc
;; Change CWD to 'enterprise/'
(define (go-enterprise) (go "enterprise"))

;;@doc
;; Change CWD to 'odoo/'
(define (go-odoo) (go "odoo"))

;;@doc
;; Change CWD to 'web_studio/'
(define (go-web_studio) (go "web_studio"))

;;@doc
;; Change CWD to 'web/'
(define (go-web) (go "web"))

;;@doc
;; Change CWD to 'dotfiles/'
(define (go-dotfiles) (go "dotfiles"))

;;@doc
;; Jump between an owl component and its template (via `owl-peeker`)
(define (owl-peek)
  (define target
    (trim (shell-capture "owl-peeker"
                         (list
                          "/home/elco/Dev/odoo"
                          (current-file)
                          (number->string (cursor-line))))))
  (if (equal? target "")
      (helix.misc.set-error! "owl-peek: no matching component/template")
      (helix.open target)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Git Blame ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;@doc
;; git blame the line under the cursor
(define (blame-line)
  (cond [(not (in-git-repo?))
         (helix.misc.set-error! "blame-line: not inside a git repository")]
        [else
         (helix.run-shell-command
          (string-join (list "git"
                             "blame"
                             "-L"
                             (string-append (number->string (cursor-line)) ",+1")
                             (current-file))
           " "))]))

;;@doc
;; git blame the current line and open the commit in a scratch buffer.
(define (show-commit-for-line)
  (cond [(not (in-git-repo?))
         (helix.misc.set-error! "show-commit-for-line: not inside a git repository")]
        [else
         (let* ([file (current-file)]
                [line (cursor-line)]
                [line-delimiter (string-append (number->string line) ",+1")]
                [args (list "blame" "-L" line-delimiter "--porcelain" file)]
                [blame (shell-capture "git" args)]
                [commit-hash (substring blame 0 40)]
                [diff (shell-capture "git" (list "show" "--no-color" commit-hash))])
           (helix.new)
           (helix.editor.set-scratch-buffer-name!
            (string-append "*git show " commit-hash "*"))
           (helix.static.insert_string diff)
           (helix.write (string-append "/tmp/blame_" commit-hash ".diff"))
           (helix.static.goto_file_start))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Keybindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(keymap
  (global)
  (normal
    (X "extend_line_above")
    ("`" ":search-word-under-cursor")
    (C-m ":scry-pipe")
    (C-p ":peek-pipe")
    (tab "jump_forward")
    (S-tab "jump_backward")
    (space
      (z
        (z "rotate_view")
        (v "vsplit")
        (s "hsplit")
        (up "jump_view_up")
        (down "jump_view_down")
        (right "jump_view_right")
        (left "jump_view_left"))
      (B
        (l ":blame-line")
        (L ":show-commit-for-line"))
      (c
        (c ":cd -- -")
        (p ":cd ..")
        (r ":goto-repo-root"))
      (C
        (o ":go-odoo")
        (c ":go-community")
        (e ":go-enterprise")
        (s ":go-web_studio")
        (w ":go-web")
        (a ":go-api-doc")
        (m ":go-mysubscription"))
      (o
        (t ":owl-peek"))
      (d ":go-dotfiles"))
    (g
      (g "goto_word")
      (G "goto_file_start")))
  (select
    (g
      (g "goto_word")
      (G "goto_file_start")))
  (insert
    (j
      (j "normal_mode"))))
