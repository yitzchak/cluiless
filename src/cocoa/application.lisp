(in-package :cluiless/cocoa)

(cffi:defcallback application-should-terminate-after-last-window-closed :boolean ((instance objc-id) (name sel) (application :pointer))
  (declare (ignore name application))
  t)

(defclass application (cluiless:application object)
  ((delegate-class
     :accessor delegate-class
     :allocation :class)))

(cluiless:defbackend :cocoa cluiless/cocoa)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (cluiless:load-backend-libraries 'objc 'cocoa 'app-kit 'foundation)

  (unless (slot-boundp instance 'delegate-class)
    (with-slots (delegate-class) instance
      (setf delegate-class
        (objc/allocate-class-pair "NSObject" "cluilessApplicationDelegate" 0))
      (class/add-protocol delegate-class "NSApplicationDelegate")
      (class/add-method delegate-class "applicationShouldTerminateAfterLastWindowClosed:" (cffi:callback application-should-terminate-after-last-window-closed) "b@:@")
      (objc/register-class-pair delegate-class)))

  (setf (handle instance) (objc/msg-send "NSApplication" "sharedApplication"))

  (let ((delegate (objc/msg-send (delegate-class instance) "new" :pointer)))
    (objc/msg-send instance "setDelegate:" :pointer
      objc-id delegate)))

(defmethod cluiless:run ((instance application))
  (trivial-main-thread:with-body-in-main-thread ()
    (float-features:with-float-traps-masked t
      (cluiless:activate instance)
      (objc/msg-send instance "run" :void))))

