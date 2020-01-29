(in-package :cluiless/cocoa)

(cffi:defcfun (get-class "objc_getClass" :library objc) :pointer
  (name :string))

(cffi:defcfun (register-name "sel_registerName" :library objc) :pointer
  (name :string))
