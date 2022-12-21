#lang scheme
(define (square x)
  (* x x))

(define (add x y)
  (+ x y))

(define (sum-of-squares x y)
  (add (square x) (square y)))

(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

(define e1.2
  (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
     (* 3 (- 6 2) (- 2 7))))

(define (e1.3 x y z)
  (cond ((or (and (>= x y) (>= y z))
             (and (>= y x) (>= x z)))
         (sum-of-squares x y))
        ((or (and (>= x z) (>= z y))
             (and (>= z x) (>= x y)))
         (sum-of-squares x z))
        ((or (and (>= y z) (>= z x))
             (and (>= z y) (>= y x)))
         (sum-of-squares y z))))

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
      guess
      (sqrt-iter (improve guess))))
  (sqrt-iter 1.0 x))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))


(define (better-sqrt x)
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? pre-guess guess)
    (< (abs (/ (- pre-guess guess) guess)) 0.001))
  (define (sqrt-iter pre-guess guess)
    (if (good-enough? pre-guess guess)
      guess
      (sqrt-iter guess (improve guess))))
  (sqrt-iter 0.0 1.0 x))


(define (cube-root x)
  (define (good-enough? pre-guess guess)
    (< (abs (/ (- pre-guess guess) guess)) 0.001))
  (define (improve guess)
    (/ (+ (/ x (square guess)) (* 2 guess)) 3))
  (define (cube-root-iter pre-guess guess)
    (if (good-enough? pre-guess guess)
        guess
        (cube-root-iter guess (improve guess))))
  (cube-root-iter 0.0 1.0))

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

(define (e1.11 n)
  (if (< n 3)
      n
      (+ (e1.11 (- n 1))
         (* 2 (e1.11 (- n 2)))
         (* 3 (e1.11 (- n 3))))))

(define (e1.11-iter n a b c)
  (cond ((= n 0) a)
        ((= n 1) b)
        ((= n 2) c)
        (else (e1.11-iter (- n 1)
                          b
                          c
                          (+ c
                             (* 2 b)
                             (* 3 a))))))

(define (e1.11-i n)
  (e1.11-iter n 0 1 2))

(define (pascal m n)
  (cond ((= n 0) 1)
        ((= m n) 1)
        (else (+ (pascal (- m 1)
                         (- n 1))
                 (pascal (- m 1)
                         n)))))

(define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                 (- counter 1)
                 (* b product))))


(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n)
         (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (fast-expt-i b n)
  (fast-expt-iter b n 1))

(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n)
         (fast-expt-iter (square b) (/ n 2) a))
        (else (fast-expt-iter b (- n 1) (* b a)))))

(define (fast-fib n)
  (fast-fib-iter 1 0 0 1 n))

(define (fast-fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fast-fib-iter a
                        b
                        (+ (square p) (square q))
                        (+ (square q) (* 2 p q))
                        (/ count 2)))
        (else (fast-fib-iter (+ (* b q) (* a q) (* a p))
                             (+ (* b p) (* a q))
                             p
                             q
                             (- count 1)))))


(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ 1 test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (congruent-modulo? a b n)
  (= (remainder a n) (remainder b n)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


; (define (sum term a next b)
; (if (> a b)
;     0
;     (+ (term a)
;        (sum term (next a) next b))))

; (define (sum term a next b)
;   (define (iter a result)
;     (if (> a b)
;         result
;         (iter (next a) (+ (term a) result))))
;   (iter a 0))

; (define (product term a next b)
; (if (> a b)
;     1
;     (* (term a)
;        (product term (next a) next b))))

; (define (product term a next b)
;   (define (iter a result)
;     (if (> a b)
;         result
;         (iter (next a) (* (term a) result))))
;     (iter a 1))

;(define (accumulate combiner null-value term a next b)
;  (if (> a b)
;     null-value
;     (combiner (term a)
;               (accumulate combiner null-value term (next a) next b))))

(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (if (filter a)
            (iter (next a) (combiner (term a) result))
            (iter (next a) result))))
  (iter a null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (fact n)
  (product identity 1 inc n))

(define (jw-pi n)
  (define (numerator n)
    (cond ((even? n) (+ n 2))
          ((odd? n) (+ n 1))))
  (define (denominator n)
    (cond ((even? n) (+ n 1))
          ((odd? n) (+ n 2))))
  (define (term n)
    (/ (numerator n) (denominator n)))
  (* 4.0 (product term 1 inc n)))

(define (cube x) (* x x x))
(define (inc n) (+ n 1))
(define (sum-cubes a b)
  (sum cube a inc b))

(define (identity x) x)
(define (sum-integers a b)
  (sum identity a inc b))

(define (pi-sum a b)
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))

(define (integral f a b dx)
  (* (sum f
          (+ a (/ dx 2.0))
          (lambda (x) (+ x dx))
          b)
     dx))

(define (sim-integral f a b n)
  (define h (/ (- b a) n))
  (define (y k) (f (+ a (* k h))))
  (define (term i)
    (cond ((= i 0) (y 0))
          ((= i n) (y n))
          ((even? i) (* 2 (y i)))
          ((odd? i) (* 4 (y i)))))
  (* (/ h 3) (sum term 0 inc n)))
