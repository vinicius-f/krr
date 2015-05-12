
(in-package :tableaux)

(defmacro by-person (a b c)
  `(quote ((or (or ,a ,b) ,c)
	   (implies ,a (and (not ,b) (not ,c)))
	   (implies ,b (and (not ,a) (not ,c)))
	   (implies ,c (and (not ,a) (not ,b))))))

(defun vestidos ()
  (let ((theory (append (by-person MA MB MP)
			(by-person CA CB CP)
			(by-person AA AB AP)
			(by-person MA AA CA)
			(by-person MB AB CB)
			(by-person MP AP CP)
			; agora considerando o que cada uma diz:
			(list '(implies AA AB)
			      '(implies CA (not AB))
			      '(not AB)
			      '(implies AP CB)))))
    (reduce (lambda (a b) `(and ,a ,b)) theory)))


(defun test-vestidos (frm)
  (labels ((present (branch)
	     (remove-duplicates	(remove-if (lambda (frm)
					     (equal 'false (formula-sign frm)))
					   branch)
				:test #'equal?)))
    (mapcar #'present (prove frm))))
