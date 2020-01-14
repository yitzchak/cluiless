(in-package :cluiless/darwin)

(defclass backend (cluiless:backend)
  ())

(push 'backend cluiless:*backend-classes*)

(defmethod initialize-instance :before ((instance backend) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (featurep :darwin)
    (error 'cluiless:backend-error)))
   
