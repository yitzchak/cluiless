(in-package #:cluiless/gtk)

(cffi:defcfun ("g_object_unref" :library glib) :void
  (object :pointer))

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

(defmethod cluiless:release ((backend (eql :gtk)) handle)
  (g-object-unref handle))        
