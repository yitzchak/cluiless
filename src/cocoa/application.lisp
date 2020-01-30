(in-package :cluiless/cocoa)

(defclass application (cluiless:application)
  ((handle
     :accessor handle)))

(cluiless:defbackend :cocoa cluiless/cocoa)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (cluiless:load-backend-libraries 'objc 'cocoa 'app-kit 'foundation)
  (setf (handle instance) (objc-msg-send "NSApplication" "shared")))

(defmethod cluiless:run ((instance application))
  (trivial-main-thread:with-body-in-main-thread ()
    (float-features:with-float-traps-masked t
      (cluiless:activate instance)
      (objc-msg-send (handle instance) "run" :void))))

