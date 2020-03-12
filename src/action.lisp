(in-package #:cluiless)

(defgeneric activate-action (name instance parameter))

(defgeneric activate (instance))

(defclass action (object)
  ((name
     :reader name
     :initarg :name)
   (icon
     :accessor icon
     :initarg :icon)
   (label
     :accessor label
     :initarg :label)
   (description
     :accessor description
     :initarg :description)
   (accelerators
     :accessor accelerators
     :initarg :accelerators
     :initform nil)
   (target
     :accessor target
     :initarg :target))
  (:metaclass object-metaclass))

(defun make-action (&rest initargs &key &allow-other-keys)
  (make-cluiless-instance "ACTION" initargs))

(defclass action-sink (object)
  ((name
     :reader name
     :initarg :name)
   (enabled
     :accessor enabled
     :initarg :enabled)
   (state
     :accessor state
     :initarg :state)
   (target
     :accessor target
     :initarg :target))
  (:metaclass object-metaclass))

(defun make-action-sink (&rest initargs &key &allow-other-keys)
  (make-cluiless-instance "ACTION-SINK" initargs))

(defgeneric add-action-sink (instance action-sink))

(defgeneric remove-action-sink (instance name-sink))

(defgeneric find-action-sink (instance name-sink))


