(in-package #:cluiless/gtk)

(defclass application (cluiless:application)
  ()
  (:metaclass cluiless:object-metaclass))

(cluiless:defbackend :gtk cluiless/gtk)

(cffi:defcallback application-activate-callback :void ((application object-handle) (data :pointer))
  (declare (ignore data))
  (cluiless:activate application))

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (cluiless:load-backend-libraries 'gtk 'glib)
  (setf (handle instance) (gtk-application-new (getf initargs :name) nil)))

(defmethod initialize-instance :after ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (g-signal-connect-data instance "activate" (cffi:callback application-activate-callback)
    (cffi:null-pointer) (cffi:null-pointer) nil))

(defmethod cluiless:run ((instance application))
  (trivial-main-thread:with-body-in-main-thread ()
    (float-features:with-float-traps-masked t
      (g-application-run instance 0 (cffi:null-pointer)))))

(defmethod cluiless:windows ((instance application))
  (gtk-application-get-windows instance))

(defmethod cluiless:window-by-id ((instance application) id)
  (gtk-application-get-window-by-id instance id))

(defmethod cluiless:add-action ((instance application) action)
  (g-action-map-add-action instance action)
  (setf (cluiless:target action) instance))
  
(defmethod cluiless:remove-action ((instance application) name)
  (g-action-map-remove-action instance name))
  
(defmethod cluiless:find-action ((instance application) name)
  (g-action-map-lookup-action instance name))
  
(defmethod cluiless:valid-sites ((instance application))
  nil)

