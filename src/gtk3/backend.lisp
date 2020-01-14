(in-package #:cluiless/gtk3)

(defclass backend (cluiless:backend)
  ())

(push 'backend cluiless:*backend-classes*)

(defmethod initialize-instance :before ((instance backend) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (handler-case (cffi:load-foreign-library 'gtk3)
    (cffi:load-foreign-library-error (condition)
      (declare (ignore condition))
      (error 'cluiless:backend-error))))
   
