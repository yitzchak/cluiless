(in-package #:cluiless/windows)

(defparameter +window-class-name+ "cluiless/window")

(defclass window (cluiless:window)
  ((cluiless:title
     :allocation :virtual)
   (class-atom
     :accessor class-atom
     :allocation :class)
   (id
     :accessor id))
  (:metaclass cluiless:object-metaclass))

(cffi:defcallback window-proc-callback :long ((instance object-handle) (msg :uint) (wparam :ulong) (lparam :long))
  (cond
    ((= msg +wm-destroy+)
      (when (remove-window cluiless::*application* (id instance))
        (post-quit-message 0))
      0)
    (t
      (def-window-proc-w instance msg wparam lparam))))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (unless (slot-boundp instance 'class-atom)
    (setf (class-atom instance)
      (register-class-ex-w
        (list :style nil
              :wnd-proc (cffi:callback window-proc-callback)
              :cls-extra 0
              :wnd-extra 0
              :instance (get-module-handle-w (cffi:null-pointer))
              :icon (cffi:null-pointer)
              :cursor (load-cursor-w (cffi:null-pointer) +c-arrow+)
              :background (cffi:make-pointer +color-window+)
              :menu-name (cffi:null-pointer)
              :class-name +window-class-name+
              :icon-sm (cffi:null-pointer)))))
  (setf (handle instance)
    (create-window-ex-w nil +window-class-name+ (getf initargs :title) :overlapped-window
      +cw-use-default+ +cw-use-default+ +cw-use-default+ +cw-use-default+
      (cffi:null-pointer) (cffi:null-pointer)
      (get-module-handle-w (cffi:null-pointer))
      (cffi:null-pointer))))

(defmethod initialize-instance :after ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (id instance) (add-window cluiless::*application* instance)))

(defmethod closer-mop:slot-value-using-class ((class cluiless:object-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (is-window-visible instance))
      ('cluiless:title
        (cffi:with-foreign-pointer-as-string ((buf len) (1+ (get-window-text-length-w instance)) :encoding :utf-16)
          (get-window-text-w instance buf len)))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:object-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (show-window instance (if new-value :show :hide)))
      ('cluiless:title
        (set-window-text-w instance new-value))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod cluiless:valid-sites ((instance window))
  nil)


