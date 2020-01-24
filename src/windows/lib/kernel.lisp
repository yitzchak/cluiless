(in-package #:cluiless/windows)

(cffi:defcfun ("GetModuleHandleW" :library kernel32) :pointer
  (module-name wstring))
