(in-package #:cluiless/win32)

(cffi:defcfun ("GetModuleHandleW" :library kernel32) :pointer
  (module-name wstring))
