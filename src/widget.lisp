(in-package #:cluiless)

(defclass widget (object)
  ((visible
     :initarg :visible
     :accessor visible
     :allocation :virtual))
  (:metaclass object-metaclass))

