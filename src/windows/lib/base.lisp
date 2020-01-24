(in-package #:cluiless/windows)

(cffi:define-foreign-library user32
  (:win32 (:default "user32")))

(cffi:define-foreign-library kernel32
  (:win32 (:default "kernel32")))

(cffi:defctype wstring (:string :encoding :utf-16))

