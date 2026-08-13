#!/usr/bin/env steel

(define-syntax my-unless
  (syntax-rules ()
    [(_ condition body)
     (if (not condition) body)]))

; (my-unless #f (displayln "piaf"))



(define x 1)
(define y 2)
(define z 3)

(define-syntax swap!
  (syntax-rules ()
    [(_ a b)
      (let ([tmp a])
        (set! tmp b)
        (set! b tmp))]
    [(_ a b c)
      (let ([tmp a])
        (set! a b)
        (set! b c)
        (set! c tmp))]))

; (swap! x y z)

; (displayln x)
; (displayln y)
; (displayln z)


; make this in scheme ?

;      perm :: [a] -> [[a]]
;      perm [] = [[]]
;      perm (h:t) = concatMap (ins h) (perm t)

;      ins :: a -> [a] -> [[a]]
;      ins x [] = [[x]]
;      ins x (h:t) = (x:h:t) : map (h:) (ins x t)

; note:
;     concatMap(l: list<list<T>>, f: T -> U) -> list<U> {
;         l.concat().map(f)
;     }

; note 2 -- ins does:
;     (ins 1 (2..n)) -> ( (1 2..n) (2 : (ins 1 3..n)) )

(define (my-map vec func)
  (cond [(empty? vec) '()]
        [(equal? (length vec) 1) (list (func (car vec)))]
        [else (cons (func (car vec)) (my-map (cdr vec) func))]))

(define (my-concat-map vecs func)
  (apply append (my-map vecs func)))

(define (ins x vec)
  (cond [(empty? vec) (list (list x))]
        [else (cons
          (cons x vec)
          (my-map
            (ins x (cdr vec))
            (lambda (tail) (cons (car vec) tail))))]))

(define (perm a)
  (cond [(empty? a) (list '())]
        [else (my-concat-map (perm (cdr a)) (lambda (v) (ins (car a) v)))]))
