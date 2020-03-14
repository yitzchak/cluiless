(in-package #:cluiless)

(defparameter *objects* (make-hash-table))

(defun object (pointer)
  (or (gethash (cffi:pointer-address pointer) *objects*)
      pointer))

(defun (setf object) (new-value pointer)
  (setf (gethash (cffi:pointer-address pointer) *objects*) new-value))

(cffi:define-foreign-type object-handle ()
  ()
  (:actual-type :pointer)
  (:simple-parser object-handle))

(defclass object-metaclass (standard-class)
  ())

(defmethod closer-mop:validate-superclass
           ((class object-metaclass) (super standard-class))
  t)

(defmethod closer-mop:compute-slots ((class object-metaclass))
  (call-next-method))

(defmethod closer-mop:slot-boundp-using-class ((class object-metaclass) object (slot closer-mop:standard-effective-slot-definition))
  (or (eql :virtual (closer-mop:slot-definition-allocation slot))
      (call-next-method)))

(defclass object ()
  ((handle
     :accessor handle
     :initarg :handle))
  (:metaclass object-metaclass))

(defmethod handle ((instance (eql nil)))
  (cffi:null-pointer))
  
(defmethod cffi:translate-to-foreign (value (type object-handle))
  (declare (ignore type))
  value)

(defmethod cffi:translate-to-foreign ((value object) (type object-handle))
  (declare (ignore type))
  (handle value))

(defmethod cffi:translate-from-foreign (value (type object-handle))
  (declare (ignore type))
  (object value))

;(defmethod (setf handle) :after (pointer (instance object))
;  (setf (object pointer) instance))

(defmethod (setf closer-mop:slot-value-using-class) :after (new-value (class cluiless:object-metaclass) (instance object) (slot closer-mop:standard-effective-slot-definition))
  (when (equal 'handle (closer-mop:slot-definition-name slot))
    (setf (object new-value) instance)))

(defgeneric release (backend handle)
  (:method (backend handle)
    (declare (ignore backend handle))))

(defmethod initialize-instance :after ((instance object) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (when (slot-boundp instance 'handle)
    (when-let ((handle (handle instance)))
      (unless (cffi:null-pointer-p handle)
        (trivial-garbage:finalize instance
          (lambda ()
            (release *backend* handle)))))))


