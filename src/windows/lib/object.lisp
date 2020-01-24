(in-package #:cluiless/windows)

(defparameter *objects* (make-hash-table))

(defclass object ()
  ((handle
     :accessor handle
     :initarg :handle)))

(cffi:define-foreign-type object-handle ()
  ()
  (:actual-type :pointer)
  (:simple-parser object-handle))

(defmethod handle ((instance (eql nil)))
  (cffi:null-pointer))

(defmethod cffi:translate-to-foreign (value (type object-handle))
  (declare (ignore type))
  value)

(defmethod cffi:translate-to-foreign ((value object) (type object-handle))
  (declare (ignore type))
  (handle value))

(defmethod cffi:translate-from-foreign (value (type object-handle))
  (declare (ignore type))
  (or (gethash (cffi:pointer-address value) *objects*)) value)

(defmethod (setf handle) :after (value (instance object))
  (setf (gethash (cffi:pointer-address value) *objects*) instance))
        
