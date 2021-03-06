(in-package :cluiless/cocoa)

(defparameter *objects* (make-hash-table))

(cffi:defctype size-t
  #+x86 :uint32
  #+x86-64 :uint64
  #-(or x86-64 x86) :long)

(cffi:defcfun ("objc_getClass" :library objc) :pointer
  (name :string))

(cffi:defcfun ("sel_registerName" :library objc) :pointer
  (name :string))

(cffi:define-foreign-type objc-id ()
  ()
  (:actual-type :pointer)
  (:simple-parser objc-id))

(defun getobject (pointer)
  (or (gethash (cffi:pointer-address pointer) *objects*) pointer))

(defclass object ()
  ((handle
     :accessor handle
     :initarg :handle)))

(defmethod (setf handle) :after (value (instance object))
  (setf (gethash (cffi:pointer-address value) *objects*) instance))

(defmethod cffi:translate-to-foreign (value (type objc-id))
  (declare (ignore type))
  value)

(defmethod cffi:translate-to-foreign ((value object) (type objc-id))
  (declare (ignore type))
  (handle value))

(defmethod cffi:translate-to-foreign ((value string) (type objc-id))
  (declare (ignore type))
  (objc/get-class value))

(defmethod cffi:translate-into-foreign-memory ((value string) (type objc-id) pointer)
  (setf (cffi:mem-aref pointer :pointer) (objc/get-class value)))

(defmethod cffi:translate-into-foreign-memory ((value object) (type objc-id) pointer)
  (setf (cffi:mem-aref pointer :pointer) (handle value)))

(defmethod cffi:translate-into-foreign-memory (value (type objc-id) pointer)
  (setf (cffi:mem-aref pointer :pointer) value))

(defmethod cffi:translate-from-foreign (value (type objc-id))
  (declare (ignore type))
  (getobject value))

(cffi:define-foreign-type sel ()
  ()
  (:actual-type :pointer)
  (:simple-parser sel))

(defmethod cffi:translate-to-foreign (value (type sel))
  (declare (ignore type))
  value)

(defmethod cffi:translate-to-foreign ((value string) (type sel))
  (declare (ignore type))
  (sel/register-name value))

(defmethod cffi:translate-into-foreign-memory ((value string) (type sel) pointer)
  (setf (cffi:mem-aref pointer :pointer) (sel/register-name value)))

(cffi:defcfun ("objc_getProtocol" :library objc) :pointer
  (name :string))

(cffi:define-foreign-type objc-protocol ()
  ()
  (:actual-type :pointer)
  (:simple-parser objc-protocol))

(defmethod cffi:translate-to-foreign (value (type objc-protocol))
  (declare (ignore type))
  value)

(defmethod cffi:translate-to-foreign ((value string) (type objc-protocol))
  (declare (ignore type))
  (objc/get-protocol value))

(defmethod cffi:translate-into-foreign-memory ((value string) (type objc-protocol) pointer)
  (setf (cffi:mem-aref pointer :pointer) (objc/get-protocol value)))

(cffi:defcfun ("objc_allocateClassPair" :library objc) :pointer
  (superclass objc-id)
  (name :string)
  (extra-bytes size-t))

(cffi:defcfun ("class_createInstance" :library objc) :pointer
  (cls objc-id)
  (extra-bytes size-t))

(cffi:defcfun ("class_replaceMethod" :library objc) :pointer
  (cls objc-id)
  (name sel)
  (imp :pointer)
  (types :string))

(cffi:defcfun ("class_addMethod" :library objc) :pointer
  (cls objc-id)
  (name sel)
  (imp :pointer)
  (types :string))

(defmacro objc/msg-send (instance selector &optional (retval 'objc-id) &rest args)
  (cond
    ((or (eq :double retval) (eq :float retval))
      `(cffi:foreign-funcall ("objc_msgSend_fpret" :library objc)
         objc-id ,instance
         sel ,selector
         ,@args
         ,retval))
    ((and (listp retval) (eq :struct (first retval)))
      (with-gensyms (struct)
        `(cffi:with-foreign-object (,struct ',retval)
           (cffi:foreign-funcall ("objc_msgSend_stret" :library objc)
             :pointer ,struct
             objc-id ,instance
             sel ,selector
             ,@args
             :void))))
    (t
      `(cffi:foreign-funcall ("objc_msgSend" :library objc)
         objc-id ,instance
         sel ,selector
         ,@args
         ,retval))))

(cffi:defcfun ("method_getTypeEncoding" :library objc) :string
  (meth :pointer))

(cffi:defcfun ("class_getInstanceMethod" :library objc) :pointer
  (cls objc-id)
  (name sel))

(cffi:defcfun ("class_addProtocol" :library objc) :bool
  (cls objc-id)
  (protocol objc-protocol))

(cffi:defcfun ("objc_registerClassPair" :library objc) :void
  (cls objc-id))
