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
      (~/init-with-content-rect=style-mask=backing=defer=
        (ns-window/alloc)
        '(:origin (:x 10.0d0 :y 10.0d0) :size (:width 640.0d0 :height 480.0d0))
        '(:titled :closable :resizable :miniaturizable)
        '(:buffered)))

    (setf (~/delegate instance)
      (objc/msg-send delegate-class "new" :pointer))

    (~/order-front-regardless instance)
    (~/make-key-and-order-front= instance (cffi:null-pointer))))

(defmethod closer-mop:slot-value-using-class ((class cluiless:object-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (~/is-visible instance))
      ('cluiless:title
        (~/title instance))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:object-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (setf (~/is-visible instance) new-value))
      ('cluiless:title
        (setf (~/title instance) new-value))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod cluiless:valid-sites ((instance window))
  nil)

