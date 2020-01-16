(in-package :cluiless/win32)

(defclass application (cluiless:application)
  ())

(push '(:win32 . application) cluiless:*application-classes*)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (featurep :win32)
    (error 'cluiless:backend-error)))
