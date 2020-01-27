(in-package #:cluiless/gtk3)

(defparameter *objects* (make-hash-table))

(defun getobject (pointer)
  (gethash (cffi:pointer-address pointer) *objects*))

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

(defmethod cffi:translate-from-foreign (value (type object-handle))
  (declare (ignore type))
  (getobject value))

(cffi:defcfun ("g_object_unref" :library glib2) :void
  (object :pointer))

(defmethod initialize-instance :after ((instance object) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (when-let ((handle (handle instance)))
    (setf (gethash (cffi:pointer-address handle) *objects*) instance)
    (trivial-garbage:finalize instance
      (lambda ()
        (g-object-unref handle)))))

(cffi:define-foreign-type g-list-object-handles ()
  ()
  (:actual-type :pointer)
  (:simple-parser g-list-object-handles))

(defmethod cffi:translate-from-foreign (value (type g-list-object-handles))
  (declare (ignore type))
  (do ((glist value (g-list-next glist))
       (result nil))
      ((cffi:null-pointer-p glist) (reverse result))
    (push (getobject (g-list-data glist)) result)))
        
