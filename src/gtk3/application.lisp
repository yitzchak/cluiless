(in-package #:cluiless/gtk3)

(defclass application (cluiless:application object)
  ())

(cluiless:defbackend :gtk3 cluiless/gtk3)

(cffi:defcallback application-activate-callback :void ((application object-handle) (data :pointer))
  (declare (ignore data))
  (cluiless:activate application))

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (cluiless:load-backend-libraries 'gtk3 'glib2)
  (setf (handle instance) (gtk-application-new (getf initargs :name) nil)))

(defmethod initialize-instance :after ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (g-signal-connect-data instance "activate" (cffi:callback application-activate-callback)
    (cffi:null-pointer) (cffi:null-pointer) nil))

(defmethod cluiless:run ((instance application))
  (trivial-main-thread:with-body-in-main-thread ()
    (float-features:with-float-traps-masked t
      (g-application-run instance 0 (cffi:null-pointer)))))

