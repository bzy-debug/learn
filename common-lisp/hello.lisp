(defun fact (n)
  "return the factorial of n"
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

(defun fib (n)
  "return the nth fibnacci number"
  (if (<= n 1)
      1
      (+ (fib (- n 1))
         (fib (- n 2)))))

(defun fib_tail (n a b)
  (if (= n 0)
      a
      (if (= n 1)
          b
          (fib_tail (- n 1)
                    b
                    (+ b a)))))

(defun fib_t (n)
  "return the nth fibnacci number"
  (fib_tail n 1 1))