(in-package #:cluiless/gtk)

(defclass window (cluiless:window object)
  ((cluiless:title
     :allocation :virtual)
   (header-bar
     :accessor header-bar)
   (menu-button
     :accessor menu-button)
   (menu
     :accessor menu))
  (:metaclass cluiless:object-metaclass))

(defmethod initialize-instance :before ((instance window) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (handle instance) (gtk-application-window-new cluiless::*application*))
  (with-slots (header-bar menu-button menu) instance
    (setf header-bar (gtk-header-bar-new))
    (setf menu-button (gtk-menu-button-new))
    (setf menu (g-menu-new))
    (gtk-widget-set-visible header-bar t)
    (gtk-header-bar-set-show-close-button header-bar t)
    (gtk-window-set-titlebar instance header-bar)
    (gtk-menu-button-set-menu-model menu-button menu)
    (gtk-button-set-image menu-button (gtk-image-new-from-icon-name "view-more-symbolic" :large-toolbar))
    (gtk-header-bar-pack-end header-bar menu-button)))

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
  (list :menu :tool-bar))

(defun ensure-header-bar (instance)
  (with-slots (header-bar) instance
    (unless header-bar
      (setf header-bar (gtk-header-bar-new))
      (gtk-widget-set-visible header-bar t)
      (gtk-header-bar-set-show-close-button header-bar t)
      (gtk-window-set-titlebar instance header-bar))))

(defun ensure-menu (instance)
  (ensure-header-bar instance)
  (with-slots (header-bar menu) instance
    (setf menu (g-menu-new))
    (let ((m (gtk-menu-button-new)))
      (gtk-menu-button-set-menu-model m menu)
      (gtk-widget-set-visible m t)
      (gtk-button-set-image m (gtk-image-new-from-icon-name "view-more-symbolic" :large-toolbar))
      (gtk-header-bar-pack-end header-bar m))))

(defun append-menu (instance menu definition)
  (case (getf definition :type :action)
    (:action
      (let* ((name (getf definition :name))
             (action (cluiless:find-action name))
             (target (if (eql :application (cluiless:target action)) "app" "win")))
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

(defmethod cluiless:append-definitions ((instance window) (site (eql :menu)) &rest definitions)
  (gtk-widget-set-visible (menu-button instance) t)
  (dolist (definition definitions)
    (append-menu instance (menu instance) definition)))

(cffi:defcallback button-clicked-callback :void ((button object-handle) (action object-handle))
  (declare (ignore data))
  (cluiless:activate-action (cluiless:name action) action nil))

(defun append-header-bar (instance header-bar definition)
  (case (getf definition :type :action)
    (:action
      (let* ((name (getf definition :name))
             (action (cluiless:find-action name))
             (target (if (eql :application (cluiless:target action)) "app" "win"))
             (button (gtk-button-new-with-label (cluiless:label action))))
        (gtk-widget-set-visible button t)
        (g-signal-connect-data button "clicked" (cffi:callback button-clicked-callback)
          action (cffi:null-pointer) nil)
        (if (eql (getf definition :location :start) :start)
          (gtk-header-bar-pack-start header-bar button)
          (gtk-header-bar-pack-end header-bar button))))))
    ; (:section
    ;   (let ((section (g-menu-new)))
    ;     (dolist (def (getf definition :children))
    ;       (append-menu instance section def))
    ;     (g-menu-append-section menu (getf definition :label) section)))
    ; (:menu
    ;   (let ((submenu (g-menu-new)))
    ;     (dolist (def (getf definition :children))
    ;       (append-menu instance submenu def))
    ;     (g-menu-append-submenu menu (getf definition :label) submenu)))))

(defmethod cluiless:append-definitions ((instance window) (site (eql :tool-bar)) &rest definitions)
  (dolist (definition definitions)
    (append-header-bar instance (header-bar instance) definition)))

(defmethod cluiless:add-action-sink ((instance window) action-sink)
  (g-action-map-add-action instance action-sink)
  (setf (cluiless:target action-sink) instance))

(defmethod cluiless:remove-action-sink ((instance window) name)
  (g-action-map-remove-action instance name))

(defmethod cluiless:find-action-sink ((instance window) name)
  (g-action-map-lookup-action instance name))

(defmethod cluiless:activate-action (name (instance window) parameter)
  (g-action-group-activate-action instance name (or parameter (cffi:null-pointer))))
