(in-package :cluiless/win32)

(defclass backend (cluiless:backend)
  ())

(push 'backend cluiless:*backend-classes*)

(defmethod initialize-instance :before ((instance backend) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (featurep :win32)
    (error 'cluiless:backend-error)))
