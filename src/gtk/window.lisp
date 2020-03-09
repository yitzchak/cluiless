(in-package #:cluiless/gtk)

(defclass window (cluiless:window object)
  ((cluiless:title
     :allocation :virtual)
   (header-bar
     :accessor header-bar))
  (:metaclass cluiless:object-metaclass))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (handle instance) (gtk-application-window-new cluiless::*application*))
  (with-slots (header-bar) instance
    (setf header-bar (gtk-header-bar-new))
    (gtk-widget-set-visible header-bar t)
    (gtk-header-bar-set-show-close-button header-bar t)
    (gtk-window-set-titlebar instance header-bar)
    (let ((m (gtk-menu-button-new))
          (q (g-menu-new)))
      (g-menu-append q "About" "app.about")
      (gtk-menu-button-set-menu-model m q)
      (gtk-widget-set-visible m t)
      (gtk-button-set-image m (gtk-image-new-from-icon-name "view-more-symbolic" :large-toolbar))
      (gtk-header-bar-pack-end header-bar m))))

(defmethod closer-mop:slot-value-using-class ((class cluiless:object-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (gtk-widget-get-visible instance))
      ('cluiless:title
        (gtk-window-get-title instance))
      (t
        (call-next-method)))
    (call-next-method)))

(defmethod (setf closer-mop:slot-value-using-class) (new-value (class cluiless:object-metaclass) (instance window) (slot closer-mop:standard-effective-slot-definition))
  (if (eql :virtual (closer-mop:slot-definition-allocation slot))
    (switch ((closer-mop:slot-definition-name slot) :test #'equal)
      ('cluiless:visible
        (gtk-widget-set-visible instance new-value))
      ('cluiless:title
        (gtk-window-set-title instance new-value))
      (t
        (call-next-method)))
    (call-next-method)))
