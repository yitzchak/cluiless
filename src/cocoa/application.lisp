(in-package :cluiless/cocoa)

(defclass application (cluiless:application)
  ())

(cluiless:defbackend :cocoa cluiless/cocoa)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (featurep :darwin)
    (error 'cluiless:backend-error)))
