(in-package #:cluiless/windows)

(cffi:defcstruct point
  (x :long)
  (y :long))

(cffi:defcstruct msg
  (hwnd :pointer)
  (message :uint)
  (w-param wparam)
  (l-param lparam)
  (time dword)
  (pt (:struct point))
  (private dword))

(cffi:defcfun ("GetMessageW" :library user32) :boolean
  (msg :pointer)
  (window :pointer)
  (filter-min :uint)
  (filter-max :uint))

(cffi:defcfun ("TranslateMessage" :library user32) :boolean
  (msg :pointer))

(cffi:defcfun ("DispatchMessageW" :library user32) lresult
  (msg :pointer))


