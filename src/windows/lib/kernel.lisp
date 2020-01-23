(in-package #:cluiless/windows)

(defcfun ("GetModuleHandleW" :library kernel32) :pointer
  (module-name wstring))
