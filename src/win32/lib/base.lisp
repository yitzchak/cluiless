(in-package #:cluiless/win32)

(cffi:define-foreign-library user32
  (:win32 (:default "user32"))
  (t (:or)))

(cffi:define-foreign-library kernel32
  (:win32 (:default "kernel32"))
  (t (:or)))

(cffi:defctype wstring (:string :encoding :utf-16))

(defmethod cffi:translate-name-from-foreign ((spec string) (package (eql *package*)) &optional varp)
  (let ((name (cffi:translate-camelcase-name spec)))
    (if varp (intern (format nil "*~a*" name)) name)))

