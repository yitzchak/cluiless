(in-package #:cluiless/windows)

(cffi:define-foreign-library user32
  (:win32 (:default "user32.dll")))

(cffi:define-foreign-library kernel32
  (:win32 (:default "kernel32.dll")))

(cffi:defctype wstring (:string :encoding :utf-16))

