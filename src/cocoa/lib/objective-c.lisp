(in-package :cluiless/cocoa)

(cffi:defcfun ("objc_getClass" :library objc) :pointer
  (name :string))

(cffi:defcfun ("sel_registerName" :library objc) :pointer
  (name :string))

(cffi:define-foreign-type id ()
  ()
  (:actual-type :pointer)
  (:simple-parser id))

(defmethod cffi:translate-to-foreign (value (type id))
  (declare (ignore type))
  value)

(defmethod cffi:translate-to-foreign ((value string) (type id))
  (declare (ignore type))
  (objc-get-class value))

(defmethod cffi:translate-from-foreign (value (type id))
  (declare (ignore type))
  value)

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

(defmacro objc-msg-send (instance selector &optional (retval 'id) &rest args)
  (let ((qargs (loop
                 for (ty val) on args by #'cddr
                 collect `(quote ,ty)
                 collect val)))
    (cond
      ((or (eq :double retval) (eq :float retval))
        `(cffi:foreign-funcall ("objc_msgSend_fpret" :library objc)
           id ,instance
           sel ,selector
           ,@qargs
           ,retval))
      ((and (listp retval) (eq :struct (first retval)))
        (with-gensyms (struct)
          `(cffi:with-foreign-object (,struct ',retval)
             (cffi:foreign-funcall ("objc_msgSend_stret" :library objc)
               :pointer ,struct
               id ,instance
               sel ,selector
               ,@qargs
               :void))))
      (t
        `(cffi:foreign-funcall ("objc_msgSend" :library objc)
           id ,instance
           sel ,selector
           ,@qargs
           ,retval)))))

