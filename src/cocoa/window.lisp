(in-package #:cluiless/cocoa)

(defclass window (cluiless:window object)
  ()
  (:metaclass cluiless:ui-metaclass))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (handle instance) (class-create-instance "NSWindow" 0))
  (init-with-content-rect/style-mask/backing/defer/ instance
    '(:origin (:x 10 :y 10) :size (:width 640 :height 480))
    '(:titled :closable :resizable)
    '(:buffered)
    nil))

(defmethod closer-mop:slot-value-using-class ((class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (is-visible instance))
      ('cluiless:title
        (title instance))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (set-is-visible/ instance new-value))
      ('cluiless:title
        (set-title/ instance new-value))
      (t
        (call-next-method)))
    (call-next-method)))
