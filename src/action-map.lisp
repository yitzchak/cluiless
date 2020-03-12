(in-package #:cluiless)

(defclass action-map ()
  ((actions
    :accessor actions
    :initform (make-hash-table :test #'eql))))

(defmethod cluiless:add-action ((instance action-map) action)
  (setf (gethash (name action) (actions instance)) action)
  (setf (target action) instance))

(defmethod cluiless:remove-action ((instance action-map) name)
  (remhash name (actions instance)))

(defmethod cluiless:find-action ((instance action-map) name)
  (gethash name (actions instance)))

