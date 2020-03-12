(in-package #:cluiless/cocoa)

(defclass action (cluiless:action)
  ((objc-class
     :accessor objc-class
     :allocation :class))
  (:metaclass cluiless:object-metaclass))

(defclass action-sink (cluiless:action-sink)
  ()
  (:metaclass cluiless:object-metaclass))

(cffi:defcallback action-activate-callback :void ((instance objc-id) (name sel))
  (declare (ignore name))
  (cluiless:activate-action
    (cluiless:name instance)
    (cluiless:find-action-sink
      (if (eql :application (cluiless:target instance))
        cluiless::*application*
        (objc/msg-send cluiless::*application* "keyWindow"))
      (cluiless:name instance))
    nil))

(defmethod initialize-instance :before ((instance action) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))

  (with-slots (objc-class handle) instance
    (unless (slot-boundp instance 'objc-class)
      (setf objc-class
        (objc/allocate-class-pair "NSObject" "cluilessAction" 0))
      (class/add-method objc-class "activate"
        (cffi:callback action-activate-callback) "v@:")
      (objc/register-class-pair objc-class))

    (setf handle (objc/msg-send objc-class "new" :pointer))))

