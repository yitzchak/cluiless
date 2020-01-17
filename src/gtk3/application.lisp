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
  (unless (cffi:foreign-library-loaded-p 'glib2)
    (handler-case
      (cffi:load-foreign-library 'glib2)
      (cffi:load-foreign-library-error (condition)
        (declare (ignore condition))
        (error 'cluiless:backend-error))))
  (setf (handle instance) (gtk-application-new (getf initargs :name) :none)))

(defmethod cluiless:run ((instance application))
  (trivial-main-thread:with-body-in-main-thread ()
    (g-application-run instance 0 (cffi:null-pointer))))
