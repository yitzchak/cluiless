(in-package #:cluiless/windows)

(cffi:define-foreign-library user32
  (:win32 (:default "user32.dll")))

