(in-package #:cluiless/gtk)

(cffi:defcfun ("g_object_unref" :library glib) :void
  (object :pointer))

; (defmethod initialize-instance :after ((instance object) &rest initargs &key &allow-other-keys)
;   (declare (ignore initargs))
;   (when-let ((handle (handle instance)))
;     (trivial-garbage:finalize instance
;       (lambda ()
;         (g-object-unref handle)))))

(cffi:define-foreign-type g-list-object-handles ()
  ()
  (:actual-type :pointer)
  (:simple-parser g-list-object-handles))

(defmethod cffi:translate-from-foreign (value (type g-list-object-handles))
  (declare (ignore type))
  (do ((glist value (g-list-next glist))
       (result nil))
      ((cffi:null-pointer-p glist) (reverse result))
    (push (object (g-list-data glist)) result)))
        
