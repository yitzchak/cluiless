(in-package #:cluiless)

(define-condition backend-error (error)
  ())

(defparameter *application-classes* nil)
(defparameter *application* nil)

(defclass application () ())

(defmethod initalize-instance :after ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setq *application* instance))

(defun make-application (&rest initargs &key backend &allow-other-keys)
  (if backend
    (let ((application-class (assoc backend *application-classes*)))
      (when application-class
        (apply #'make-instance (cdr application-class) initargs)))
    (or *application*
      (dolist (application-class (mapcar #'cdr *application-classes*))
        (handler-case (return (apply #'make-instance application-class initargs))
          (backend-error (condition)
            (declare (ignore condition))))))))

(defgeneric run (instance))
