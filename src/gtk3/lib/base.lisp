(in-package #:cluiless/gtk3)

(cffi:define-foreign-library gtk3
  (t (:default "libgtk-3")))

(defclass object ()
  ((handle
     :accessor handle
     :initarg :handle)))

(cffi:define-foreign-type object-handle ()
  ()
  (:actual-type :pointer)
  (:simple-parser object-handle))

(defmethod cffi:translate-to-foreign (value (type object-handle))
  (declare (ignore type))
  (handle value))
     
