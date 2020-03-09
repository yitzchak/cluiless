(in-package #:cluiless)

(define-condition backend-error (error)
  ())

(defparameter *application-classes* nil)
(defparameter *application* nil)
(defparameter *backends* nil)
(defparameter *backend* nil)

(defmacro defbackend (name pkg)
  `(push (cons (quote ,name) (quote ,pkg)) *backends*))

(defclass application (object)
  ()
  (:metaclass object-metaclass))

(defmethod initialize-instance :after ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setq *application* instance))

(defun make-cluiless-instance (name initargs &key (backend *backend*))
  (apply #'make-instance (find-symbol name (cdr backend)) initargs))

(defun make-application (&rest initargs &key backends &allow-other-keys)
  (or *application*
    (dolist (candidate (if backends
                         (mapcan (lambda (name)
                                   (when-let ((c (assoc name *backends*)))
                                     (list c)))
                           backends)
                         *backends*))
      (handler-case
        (let ((app (make-cluiless-instance "APPLICATION" initargs :backend candidate)))
          (setq *backend* candidate)
          (return app))
        (backend-error (condition)
          (declare (ignore condition)))))))

(defgeneric run (instance))

(defgeneric activate (instance))

(defun load-backend-libraries (&rest libraries)
  (dolist (library libraries)
    (unless (cffi:foreign-library-loaded-p library)
      (handler-case
        (cffi:load-foreign-library library)
        (cffi:load-foreign-library-error (condition)
          (declare (ignore condition))
          (error 'cluiless:backend-error))))))


(defgeneric windows (instance))

(defgeneric window-by-id (instance id))
