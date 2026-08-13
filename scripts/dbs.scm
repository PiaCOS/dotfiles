#!/usr/bin/env steel

(require "steel/result")
(require-builtin "steel/process")


(define (pipe-to-fzf cmd args header)
  (define (capture-output cmd args)
    (~> (command cmd args)
      with-stdout-piped
      spawn-process
      unwrap-ok
      wait->stdout
      unwrap-ok))

  (define (stdin-piped cmd args)
    (~> (command cmd args)
      with-stdin-piped
      spawn-process
      unwrap-ok))

  (let* ([output (capture-output cmd args)]
         [fzf (stdin-piped "fzf" (list (string-append "--header=\"" header "\"")))]
         [fzf-in (child-stdin fzf)])
    (write-string output fzf-in)
    (close-output-port fzf-in)
    (wait fzf)))


(pipe-to-fzf
  "psql"
  (list "-U" "postgres" "-t" "-A" "-c" "SELECT datname FROM pg_database WHERE datistemplate = false;")
  ":: Choose a database ::")
