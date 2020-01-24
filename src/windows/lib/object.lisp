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

(defmethod cffi:translate-to-foreign (value (type object-handle))
  (declare (ignore type))
  (handle value))

(defmethod cffi:translate-from-foreign (value (type object-handle))
  (declare (ignore type))
  (gethash (cffi:pointer-address value) *objects*))

(defmethod initialize-instance :after ((instance object) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (when-let ((handle (handle instance)))
    (setf (gethash (cffi:pointer-address handle) *objects*) instance)))
        
