(in-package #:cluiless/windows)

(defclass action (cluiless:action)
  ()
  (:metaclass cluiless:object-metaclass))

(defclass action (cluiless:action-sink)
  ()
  (:metaclass cluiless:object-metaclass))
