(in-package #:cluiless/gtk)

(defclass action (cluiless:action)
  ((name
     :allocation :virtual))
  (:metaclass cluiless:object-metaclass))

(cffi:defcallback action-activate-callback :void ((action object-handle) (parameter :pointer) (data :pointer))
  (declare (ignore parameter data))
  (cluiless:activate action))

(defmethod initialize-instance :before ((instance action) &rest initargs &key &allow-other-keys)
  (setf (handle instance)
        (g-simple-action-new (getf initargs :name) (cffi:null-pointer))))

(defmethod closer-mop:slot-value-using-class ((class cluiless:object-metaclass) (instance action) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:name
        (g-action-get-name instance))
      (t
        (call-next-method)))
    (call-next-method)))

; (defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:object-metaclass) (instance action) (slot closer-mop:standard-effective-slot-definition))
;   (if (eql :virtual (closer-mop:slot-definition-allocation slot))
;     (switch ((closer-mop:slot-definition-name slot) :test #'equal)
;       ('cluiless:name
;         (gtk-widget-set-visible instance new-value))
;       (t
;         (call-next-method)))
;     (call-next-method)))
