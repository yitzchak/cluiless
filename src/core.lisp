(in-package :cluiless)

(defclass ui-metaclass (standard-class)
  ())

(defmethod closer-mop:validate-superclass
           ((class ui-metaclass) (super standard-class))
  t)

(defmethod closer-mop:compute-slots ((class ui-metaclass))
  (call-next-method))

(defmethod closer-mop:slot-boundp-using-class ((class ui-metaclass) object (slot closer-mop:standard-effective-slot-definition))
  (or (eql :ui-instance (closer-mop:slot-definition-allocation slot))
      (call-next-method)))


