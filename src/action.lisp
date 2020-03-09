(in-package #:cluiless)

(defgeneric activate (instance))

(defgeneric add-action (instance action))

(defgeneric remove-action (instance name))

(defgeneric find-action (instance name))

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
   (enabled
     :accessor enabled
     :initarg :enabled
     :initform t)
   (state
     :accessor state
     :initarg :state))
  (:metaclass object-metaclass))

(defun make-action (&rest initargs &key &allow-other-keys)
  (make-cluiless-instance "ACTION" initargs))

