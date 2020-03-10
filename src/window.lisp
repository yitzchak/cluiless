(in-package #:cluiless)

(defclass window (widget)
  ((title
     :initarg :title
     :accessor title))
  (:metaclass object-metaclass))

(defun make-window (&rest initargs &key &allow-other-keys)
  (make-cluiless-instance "WINDOW" initargs))

(defgeneric valid-sites (instance))

(defgeneric append-definitions (instance site &rest definitions))

(defun valid-site-p (instance site)
  (member site (valid-sites instance) :test #'eql))
