(in-package :cluiless/cocoa)

; The trailing :or for alternate libraries will make the library load fail on unsupported platforms.

(cffi:define-foreign-library objc
  (:darwin (:default "libobjc"))
  (t (:or)))

(cffi:define-foreign-library cocoa
  (:darwin (:framework "Cocoa"))
  (t (:or)))

(cffi:define-foreign-library app-kit
  (:darwin (:framework "AppKit"))
  (t (:or)))

(cffi:define-foreign-library foundation
  (:darwin (:framework "Foundation"))
  (t (:or)))

(defun lispify-name (name)
  (cffi:translate-camelcase-name
    (substitute #\= #\: (substitute #\/ #\_ name))
    :special-words '("NS")))

(defmethod cffi:translate-name-from-foreign ((spec string) (package (eql *package*)) &optional varp)
  (let ((name (lispify-name spec)))
    (if varp (intern (format nil "*~a*" name)) name)))

