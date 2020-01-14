(in-package #:cluiless)

(define-condition backend-error (error)
  ())

(defparameter *backend-classes* nil)
(defparameter *backend* nil)

(defclass backend () ())

(defun do-initialize-backend (backend-class)
  (setq *backend* (make-instance backend-class)))

(defun initialize-backend (&optional backend-class)
  (if backend-class
    (do-initialize-backend backend-class)
    (or *backend*
      (dolist (backend-class *backend-classes*)
        (handler-case (return (do-initialize-backend backend-class))
          (backend-error (condition)
            (declare (ignore condition))))))))


