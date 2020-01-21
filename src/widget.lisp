(in-package #:cluiless)

(defclass widget ()
  ((visible
     :initarg :visible
     :accessor visible
     :allocation :ui-instance))
  (:metaclass ui-metaclass))

