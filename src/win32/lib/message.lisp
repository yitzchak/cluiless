(in-package #:cluiless/win32)

(cffi:defcstruct point
  (x :long)
  (y :long))

(cffi:defcstruct msg
  (hwnd :pointer)
  (message :uint)
  (wparam :ulong)
  (lparam :long)
  (time :uint32)
  (pt (:struct point))
  (private :uint32))

(cffi:defcfun ("GetMessageW" :library user32) :int
  (msg :pointer)
  (window :pointer)
  (filter-min :uint)
  (filter-max :uint))

(cffi:defcfun ("TranslateMessage" :library user32) :int
  (msg :pointer))

(cffi:defcfun ("DispatchMessageW" :library user32) :long
  (msg :pointer))

(cffi:defcfun ("PostQuitMessage" :library user32) :void
  (exit-code :int))

(defparameter +wm-destroy+ #x2)

