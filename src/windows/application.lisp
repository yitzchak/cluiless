(in-package :cluiless/windows)

(defclass application (cluiless:application)
  ())

(cluiless:defbackend :windows cluiless/windows)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (featurep :win32)
    (error 'cluiless:backend-error))
  (unless (cffi:foreign-library-loaded-p 'user32)
    (handler-case
      (cffi:load-foreign-library 'user32)
      (cffi:load-foreign-library-error (condition)
        (declare (ignore condition))
        (error 'cluiless:backend-error))))
  (unless (cffi:foreign-library-loaded-p 'kernel32)
    (handler-case
      (cffi:load-foreign-library 'kernel32)
      (cffi:load-foreign-library-error (condition)
        (declare (ignore condition))
        (error 'cluiless:backend-error)))))

