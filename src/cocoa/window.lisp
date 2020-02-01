(in-package #:cluiless/cocoa)

(cffi:defcallback window-will-close :pointer ((instance objc-id) (name sel) (notification :pointer))
  (declare (ignore name notification))
  (format t "window-will-close ~A~%" instance)
  (cffi:null-pointer))

(defclass window (cluiless:window object)
  ((delegate-class
     :accessor delegate-class
     :allocation :class))
  (:metaclass cluiless:ui-metaclass))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))

  (unless (slot-boundp instance 'delegate-class)
    (with-slots (delegate-class) instance
      (setf delegate-class
        (objc/allocate-class-pair "NSObject" "cluilessWindowDelegate" 0))
      (class/add-protocol delegate-class (objc/get-protocol "NSWindowDelegate"))))
;      (class/add-protocol delegate-class (objc/get-protocol "NSObject"))))
;      (class/replace-method delegate-class "windowWillClose:" (cffi:callback window-will-close) "v@:@")))

  (setf (handle instance)
    (objc/msg-send (objc/msg-send "NSWindow" "alloc" :pointer) "initWithContentRect:styleMask:backing:defer:"
      :pointer
      (:struct ns-rect) '(:origin (:x 10.0d0 :y 10.0d0) :size (:width 640.0d0 :height 480.0d0))
      ns-window-style-mask '(:titled :closable :resizable)
      ns-backing-store-type '(:buffered)
      ));:bool nil)))

;  (let ((delegate (objc/msg-send (delegate-class instance) "alloc" :pointer)))
;    (objc/msg-send instance "init" :pointer)
;    (objc/msg-send instance "setDelegate:" :pointer
;      objc-id delegate))

  (objc/msg-send instance "orderFrontRegardless" :void))

(defmethod closer-mop:slot-value-using-class ((class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (objc/msg-send instance "isVisible" :boolean))
      ('cluiless:title
        (objc/msg-send instance "title" ns-string))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (objc/msg-send instance "setIsVisible:" :void :boolean new-value))
      ('cluiless:title
        (objc/msg-send instance "setTitle:" :void ns-string new-value))
      (t
        (call-next-method)))
    (call-next-method)))
