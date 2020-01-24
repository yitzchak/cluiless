(in-package #:cluiless/window)

(defparameter +window-class-name+ "cluiless/window")

(defclass window (cluiless:window object)
  ((class-atom
     :accessor class-atom
     :allocation :class))
  (:metaclass cluiless:ui-metaclass))

(cffi:defcallback window-proc-callback lresult ((instance object-handle) (msg :uint) (w-param wparam) (l=param lparam)))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (slot-boundp instance 'class-atom)
    (setf (class-atom instance)
      (register-class-ex-w
        (:size (cffi:foreign-type-size 'wndclassexw)
         :class-name +window-class-name+
         :wnd-proc (cffi:callback window-proc-callback)
         :instance (get-module-handle-w (cffi:null-pointer)))))))
;  (setf (handle instance) (gtk-application-window-new cluiless::*application*)))

(defmethod closer-mop:slot-value-using-class ((class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
;      ('cluiless:visible
;        (gtk-widget-get-visible instance))
;      ('cluiless:title
;        (gtk-window-get-title instance))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
;      ('cluiless:visible
;        (gtk-widget-set-visible instance new-value))
;      ('cluiless:title
;        (gtk-window-set-title instance new-value))
      (t
        (call-next-method)))
    (call-next-method)))
