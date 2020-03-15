(in-package #:cluiless/gtk)

(defclass action (cluiless:action)
  ()
  (:metaclass cluiless:object-metaclass))

(defclass action-sink (cluiless:action-sink)
  ((cluiless:name
     :allocation :virtual)
   (cluiless:enabled
     :allocation :virtual))
  (:metaclass cluiless:object-metaclass))

(cffi:defcallback action-activate-callback :void ((action object-handle) (parameter :pointer) (data :pointer))
  (declare (ignore parameter data))
  (cluiless:activate-action (cluiless:name action) action nil))

(defmethod initialize-instance :before ((instance action) &rest initargs &key &allow-other-keys)
  (setf (handle instance)
        (g-object-new-with-properties +g-type-object+ 0 (cffi:null-pointer) (cffi:null-pointer))))

(defmethod initialize-instance :before ((instance action-sink) &rest initargs &key &allow-other-keys)
  (setf (handle instance)
        (g-simple-action-new (getf initargs :name) (cffi:null-pointer))))

(defmethod initialize-instance :after ((instance action-sink) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (g-signal-connect-data instance "activate" (cffi:callback action-activate-callback)
    (cffi:null-pointer) (cffi:null-pointer) nil))

(defmethod closer-mop:slot-value-using-class ((class cluiless:object-metaclass) (instance action-sink) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:name
        (g-action-get-name instance))
      ('cluiless:enabled
        (g-action-get-enabled instance))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:object-metaclass) (instance action-sink) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:name)
      ('cluiless:enabled
        (g-simple-action-set-enabled instance new-value))
      (t
        (call-next-method)))
    (call-next-method)))
