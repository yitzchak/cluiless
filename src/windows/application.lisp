(in-package :cluiless/windows)

(defclass application (cluiless:application)
  ())

(cluiless:defbackend :windows cluiless/windows)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (featurep :win32)
    (error 'cluiless:backend-error))
  (cluiless:load-backend-libraries 'user32 'kernel32))

