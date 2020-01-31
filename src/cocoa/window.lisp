(in-package #:cluiless/cocoa)

(defclass window (cluiless:window object)
  ()
  (:metaclass cluiless:ui-metaclass))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (handle instance) (class-create-instance "NSWindow" 0))
  (objc-msg-send instance "initWithContentRect:styleMask:backing:defer:"
    :pointer
    (:struct ns-rect) '(:origin (:x 10 :y 10) :size (:width 640 :height 480))
    ns-window-style-mask '(:titled :closable :resizable)
    ns-backing-store-type '(:buffered)
    :boolean nil))

(defmethod closer-mop:slot-value-using-class ((class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (objc-msg-send instance "isVisible" :boolean))
      ('cluiless:title
        (objc-msg-send instance "title" ns-string))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (objc-msg-send instance "setIsVisible:" :void :boolean new-value))
      ('cluiless:title
        (objc-msg-send instance "setTitle:" :void ns-string new-value))
      (t
        (call-next-method)))
    (call-next-method)))
