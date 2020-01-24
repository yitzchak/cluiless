(in-package :cluiless/windows)

(defclass application (cluiless:application)
  ())

(cluiless:defbackend :windows cluiless/windows)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (featurep :win32)
    (error 'cluiless:backend-error))
  (cluiless:load-backend-libraries 'user32 'kernel32))

(defmethod cluiless:run ((instance application))
  (trivial-main-thread:with-body-in-main-thread ()
    (float-features:with-float-traps-masked t
      (cluiless:activate instance)
      (cffi:with-foreign-object (m 'msg)
      (do ()
          ((get-message-w m (cffi:null-pointer) 0 0))
        (translate-message m)
        (dispatch-message-w m))))))

