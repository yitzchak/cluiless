(in-package #:cluiless)

(defclass action-sink-map ()
  ((action-sinks
    :accessor action-sinks
    :initform (make-hash-table :test #'eql))))

(defmethod cluiless:add-action-sink ((instance action-sink-map) action-sink)
  (setf (gethash (name action-sink) (action-sinks instance)) action-sink)
  (setf (target action-sink) instance))

(defmethod cluiless:remove-action-sink ((instance action-sink-map) name)
  (remhash name (action-sinks instance)))

(defmethod cluiless:find-action-sink ((instance action-sink-map) name)
  (gethash name (action-sinks instance)))

