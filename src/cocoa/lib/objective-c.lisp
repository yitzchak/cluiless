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

(cffi:define-foreign-type id ()
  ()
  (:actual-type :pointer)
  (:simple-parser id))

(defun getobject (pointer)
  (or (gethash (cffi:pointer-address pointer) *objects*) pointer))

(defclass object ()
  ((handle
     :accessor handle
     :initarg :handle)))

(defmethod cffi:translate-to-foreign (value (type id))
  (declare (ignore type))
  value)

(defmethod cffi:translate-to-foreign ((value object) (type id))
  (declare (ignore type))
  (handle value))

(defmethod cffi:translate-to-foreign ((value string) (type id))
  (declare (ignore type))
  (objc-get-class value))

(defmethod cffi:translate-from-foreign (value (type id))
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
  (sel-register-name value))

(cffi:defcfun ("class_createInstance" :library objc) :pointer
  (cls id)
  (extra-bytes size-t))

(defmacro objc-msg-send (instance selector &optional (retval 'id) &rest args)
  (cond
    ((or (eq :double retval) (eq :float retval))
      `(cffi:foreign-funcall ("objc_msgSend_fpret" :library objc)
         id ,instance
         sel ,selector
         ,@args
         ,retval))
    ((and (listp retval) (eq :struct (first retval)))
      (with-gensyms (struct)
        `(cffi:with-foreign-object (,struct ',retval)
           (cffi:foreign-funcall ("objc_msgSend_stret" :library objc)
             :pointer ,struct
             id ,instance
             sel ,selector
             ,@args
             :void))))
    (t
      `(cffi:foreign-funcall ("objc_msgSend" :library objc)
         id ,instance
         sel ,selector
         ,@args
         ,retval))))

