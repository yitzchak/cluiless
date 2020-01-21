(in-package #:cluiless/gtk3)

(defclass window (cluiless:window object)
  ()
  (:metaclass cluiless:ui-metaclass))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (handle instance) (gtk-application-window-new cluiless::*application*)))

(defmethod cluiless:do-make-window ((application-instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore application-instance))
  (apply #'make-instance 'window initargs))

(defmethod closer-mop:slot-value-using-class ((class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (gtk-widget-get-visible instance))
      ('cluiless:title
        (gtk-window-get-title instance))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:ui-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :ui-instance (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (gtk-widget-set-visible instance new-value))
      ('cluiless:title
        (gtk-window-set-title instance new-value))
      (t
        (call-next-method)))
    (call-next-method)))
