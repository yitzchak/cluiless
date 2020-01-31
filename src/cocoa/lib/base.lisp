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

(defmethod cffi:translate-name-from-foreign ((spec string) (package (eql *package*)) &optional varp)
  (let ((name (cffi:translate-camelcase-name (substitute #\- #\_ spec) :special-words '("NS"))))
    (if varp (intern (format nil "*~a*" name)) name)))

