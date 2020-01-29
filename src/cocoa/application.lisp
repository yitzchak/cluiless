(in-package :cluiless/cocoa)

(defclass application (cluiless:application)
  ())

(cluiless:defbackend :cocoa cluiless/cocoa)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (cluiless:load-backend-libraries 'objc 'cocoa 'app-kit 'foundation))

