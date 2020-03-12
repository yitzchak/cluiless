(in-package #:cluiless/gtk)

(defclass window (cluiless:window object)
  ((cluiless:title
     :allocation :virtual)
   (header-bar
     :accessor header-bar)
   (primary-menu-button
     :accessor primary-menu-button)
   (primary-menu
     :accessor primary-menu))
  (:metaclass cluiless:object-metaclass))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (handle instance) (gtk-application-window-new cluiless::*application*))
  (with-slots (header-bar primary-menu-button primary-menu) instance
    (setf header-bar (gtk-header-bar-new))
    (setf primary-menu-button (gtk-menu-button-new))
    (setf primary-menu (g-menu-new))
    (gtk-widget-set-visible header-bar t)
    (gtk-header-bar-set-show-close-button header-bar t)
    (gtk-window-set-titlebar instance header-bar)
    (gtk-menu-button-set-menu-model primary-menu-button primary-menu)
    (gtk-button-set-image primary-menu-button (gtk-image-new-from-icon-name "view-more-symbolic" :large-toolbar))
    (gtk-header-bar-pack-end header-bar primary-menu-button)))

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

(defmethod cluiless:valid-sites ((instance window))
  (list :primary-menu))

(defun ensure-header-bar (instance)
  (with-slots (header-bar) instance
    (unless header-bar
      (setf header-bar (gtk-header-bar-new))
      (gtk-widget-set-visible header-bar t)
      (gtk-header-bar-set-show-close-button header-bar t)
      (gtk-window-set-titlebar instance header-bar))))

(defun ensure-primary-menu (instance)
  (ensure-header-bar instance)
  (with-slots (header-bar primary-menu) instance
    (setf primary-menu (g-menu-new))
    (let ((m (gtk-menu-button-new)))
      (gtk-menu-button-set-menu-model m primary-menu)
      (gtk-widget-set-visible m t)
      (gtk-button-set-image m (gtk-image-new-from-icon-name "view-more-symbolic" :large-toolbar))
      (gtk-header-bar-pack-end header-bar m))))

(defun append-menu (instance menu definition)
  (case (getf definition :type :action)
    (:action
      (let* ((name (getf definition :name))
             (target (if (eql (getf definition :target :window) :window) "win" "app"))
             (action (cluiless:find-action instance name)))
        (g-menu-append menu (cluiless:label action) (format nil "~A.~A" target name))))
    (:section
      (let ((section (g-menu-new)))
        (dolist (def (getf definition :children))
          (append-menu instance section def))
        (g-menu-append-section menu (getf definition :label) section)))
    (:menu
      (let ((submenu (g-menu-new)))
        (dolist (def (getf definition :children))
          (append-menu instance submenu def))
        (g-menu-append-submenu menu (getf definition :label) submenu)))))

(defmethod cluiless:append-definitions ((instance window) (site (eql :primary-menu)) &rest definitions)
  (gtk-widget-set-visible (primary-menu-button instance) t)
  (dolist (definition definitions)
    (append-menu instance (primary-menu instance) definition)))

(defmethod cluiless:add-action ((instance window) action)
  (g-action-map-add-action instance action)
  (setf (cluiless:target action) instance))

(defmethod cluiless:remove-action ((instance window) name)
  (g-action-map-remove-action instance name))

(defmethod cluiless:find-action ((instance window) name)
  (g-action-map-lookup-action instance name))
