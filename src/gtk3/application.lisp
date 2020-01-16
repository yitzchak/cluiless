(in-package #:cluiless/gtk3)

(defclass application (cluiless:application object)
  ())

(push '(:gtk3 . application) cluiless:*application-classes*)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (unless (cffi:foreign-library-loaded-p 'gtk3)
    (handler-case
      (cffi:load-foreign-library 'gtk3)
      (cffi:load-foreign-library-error (condition)
        (declare (ignore condition))
        (error 'cluiless:backend-error))))
  (setf (handle instance) (gtk-application-new (getf initargs :name) :none)))
