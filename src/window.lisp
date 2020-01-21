(in-package #:cluiless)

(defclass window (widget)
  ()
  (:metaclass ui-metaclass))

(defun make-window (&rest initargs &key &allow-other-keys)
  (make-cluiless-instance "WINDOW" initargs))


