(in-package :cluiless/cocoa)

(defclass application (cluiless:application)
  ())

(push '(:cocoa . application) cluiless:*application-classes*)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (featurep :darwin)
    (error 'cluiless:backend-error)))
