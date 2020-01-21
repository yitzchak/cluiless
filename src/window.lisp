(in-package #:cluiless)

(defclass window (widget)
  ()
  (:metaclass ui-metaclass))

(defgeneric do-make-window (application &rest initargs &key &allow-other-keys))

(defun make-window (&rest initargs &key &allow-other-keys)
  (apply #'do-make-window *application* initargs))


