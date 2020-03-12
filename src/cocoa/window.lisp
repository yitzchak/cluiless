(in-package #:cluiless/cocoa)

(cffi:defcallback window-will-close :pointer ((instance objc-id) (name sel) (notification :pointer))
  (declare (ignore instance name notification))
  (cffi:null-pointer))

(defclass window (cluiless:window cluiless:action-sink-map)
  ((cluiless:title
     :allocation :virtual)
   (delegate-class
     :accessor delegate-class
     :allocation :class))
  (:metaclass cluiless:object-metaclass))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (with-slots (delegate-class handle) instance
    (unless (slot-boundp instance 'delegate-class)
      (setf delegate-class
        (objc/allocate-class-pair "NSObject" "CluilessWindowDelegate" 0))
      (class/add-protocol delegate-class "NSWindowDelegate")
      (class/add-method delegate-class "windowWillClose:" (cffi:callback window-will-close) "v@:@")
      (objc/register-class-pair delegate-class))

    (setf handle
      (objc/msg-send (objc/msg-send "NSWindow" "alloc" :pointer) "initWithContentRect:styleMask:backing:defer:"
        :pointer
        (:struct ns-rect) '(:origin (:x 10.0d0 :y 10.0d0) :size (:width 640.0d0 :height 480.0d0))
        ns-window-style-mask '(:titled :closable :resizable)
        ns-backing-store-type '(:buffered)))

    (objc/msg-send instance "setDelegate:" :pointer
      objc-id (objc/msg-send delegate-class "new" :pointer))

    (objc/msg-send instance "orderFrontRegardless" :void)))

(defmethod closer-mop:slot-value-using-class ((class cluiless:object-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (objc/msg-send instance "isVisible" :boolean))
      ('cluiless:title
        (objc/msg-send instance "title" ns-string))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:object-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (objc/msg-send instance "setIsVisible:" :void :boolean new-value))
      ('cluiless:title
        (objc/msg-send instance "setTitle:" :void ns-string new-value))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod cluiless:valid-sites ((instance window))
  nil)

