(in-package #:cluiless/gtk3)

(defclass object ()
  ((handle
     :accessor handle
     :initarg :handle)))

(cffi:define-foreign-type object-handle ()
  ()
  (:actual-type :pointer)
  (:simple-parser object-handle))

(defmethod cffi:translate-to-foreign (value (type object-handle))
  (declare (ignore type))
  (handle value))

(cffi:defcfun ("g_object_unref" :library glib2) :void
  (object :pointer))

(defmethod initilize-instance :after ((instance object) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (when-let ((handle (handle instance)))
    (trivial-garbage:finalize instance
      (lambda ()
        (g-object-unref handle)))))
        
