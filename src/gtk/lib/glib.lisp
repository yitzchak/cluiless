(in-package :cluiless/gtk)

(cffi:defcstruct glist
  (data :pointer)
  (next (:pointer (:struct glist)))
  (prev (:pointer (:struct glist))))

(defun g-list-data (glist)
  (cffi:foreign-slot-value glist '(:struct glist) 'data))

(defun g-list-next (glist)
  (cffi:foreign-slot-value glist '(:struct glist) 'next))

(defun g-list-prev (glist)
  (cffi:foreign-slot-value glist '(:struct glist) 'prev))  
