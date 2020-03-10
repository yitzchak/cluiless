(in-package :cluiless/cocoa)

(cffi:defcallback application-should-terminate-after-last-window-closed :boolean ((instance objc-id) (name sel) (application :pointer))
  (declare (ignore instance name application))
  t)

(defclass application (cluiless:application)
  ((delegate-class
     :accessor delegate-class
     :allocation :class))
  (:metaclass cluiless:object-metaclass))

(cluiless:defbackend :cocoa cluiless/cocoa)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (cluiless:load-backend-libraries 'objc 'cocoa 'app-kit 'foundation)

  (with-slots (delegate-class handle) instance
    (unless (slot-boundp instance 'delegate-class)
      (setf delegate-class
        (objc/allocate-class-pair "NSObject" "cluilessApplicationDelegate" 0))
      (class/add-protocol delegate-class "NSApplicationDelegate")
      (class/add-method delegate-class "applicationShouldTerminateAfterLastWindowClosed:"
        (cffi:callback application-should-terminate-after-last-window-closed) "c@:@")
      (objc/register-class-pair delegate-class))

    (setf handle (objc/msg-send "NSApplication" "sharedApplication"))

    (objc/msg-send instance "setDelegate:" :pointer
      objc-id (objc/msg-send delegate-class "new" :pointer))))

(defmethod cluiless:run ((instance application))
  (trivial-main-thread:with-body-in-main-thread ()
    (float-features:with-float-traps-masked t
      (cluiless:activate instance)
      (objc/msg-send instance "run" :void))))

(defmethod cluiless:valid-sites ((instance application))
  (list :primary-menu))

