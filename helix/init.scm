(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))
(require "helix/static.scm")
(require "helix/editor.scm")
(require "helix/keymaps.scm")
(require "helix/misc.scm")
(require (only-in "helix/ext.scm" evalp eval-buffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Helper ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (current-file)
  (cx->current-file))

(define (cursor-line)
  (+ 1 (get-current-line-number)))


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
  (define lang (editor-document->language (editor->doc-id (editor-focus))))
  (helix.pipe "peek" (if (string? lang) lang ""))
  (helix.static.collapse_selection))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Git Blame ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;@doc
;; git blame the line under the cursor
(define (blame-line)
  (helix.run-shell-command
   (string-join (list "git" "blame" "-L" (string-append (number->string (cursor-line)) ",+1")
                       (current-file))
                " ")))

;;@doc
;; git blame the current line and open the commit in a scratch buffer.
(define (show-commit-for-line)
  (define file (current-file))
  (define line (cursor-line))
  (define out-file "/tmp/hx-git-show.diff")
  (helix.run-shell-command
   (string-append "commit_hash=$(git blame -L "
                  (number->string line)
                  ",+1 --porcelain "
                  file
                  " | head -n 1 | awk '{print $1}'); git show \"$commit_hash\" > "
                  out-file))
  (helix.open out-file))

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
   (z (z "rotate_view")
      (v "vsplit")
      (s "hsplit")
      (up "jump_view_up")
      (down "jump_view_down")
      (right "jump_view_right")
      (left "jump_view_left"))
   (B
     (l ":blame-line")
     (L ":show-commit-for-line")
     ))
  (g (g "goto_word") (G "goto_file_start")))
 (select
  (g (g "goto_word") (G "goto_file_start")))
 (insert
  (j (j "normal_mode"))))
