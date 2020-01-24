(in-package #:cluiless/windows)

(defparameter +window-class-name+ "cluiless/window")

(defclass window (cluiless:window object)
  ((class-atom
     :accessor class-atom
     :allocation :class))
  (:metaclass cluiless:ui-metaclass))

(cffi:defcallback window-proc-callback lresult ((instance object-handle) (msg :uint) (w-param wparam) (l-param lparam))
  0)

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (slot-boundp instance 'class-atom)
    (setf (class-atom instance)
      (register-class-ex-w
        (list :class-name +window-class-name+
              :wnd-proc (cffi:callback window-proc-callback)
              :instance (get-module-handle-w (cffi:null-pointer))))))
  (setf (handle instance)
    (create-window-ex-w nil +window-class-name+ (getf initargs :title) :overlapped-window
      10 10 100 100
      (cffi:null-pointer) (cffi:null-pointer)
      (get-module-handle-w (cffi:null-pointer))
      (cffi:null-pointer))))

(defmethod closer-mop:slot-value-using-class ((class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (is-window-visible instance))
      ('cluiless:title
        (cffi:with-foreign-pointer-as-string (buf (1+ (get-window-length-w instance)) :size-var len :encoding :utf-16)
          (get-window-text-w instance buf len)))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (show-window instance (if new-value :show :hide)))
      ('cluiless:title
        (set-window-text-w instance new-value))
      (t
        (call-next-method)))
    (call-next-method)))
