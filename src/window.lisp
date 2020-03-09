(in-package #:cluiless)

(defclass window (widget)
  ((title
     :initarg :title
     :accessor title))
  (:metaclass object-metaclass))

(defun make-window (&rest initargs &key &allow-other-keys)
  (make-cluiless-instance "WINDOW" initargs))


