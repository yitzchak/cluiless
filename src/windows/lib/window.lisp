(in-package #:cluiless/windows)

(cffi:defcstruct wndclassexw
  (:size :uint)
  (:style class-style)
  (:wnd-proc :pointer)
  (:cls-extra :int)
  (:wnd-extra :int)
  (:instance :pointer)
  (:icon :pointer)
  (:cursor :pointer)
  (:background :pointer)
  (:menu-name wstring)
  (:class-name wstring)
  (:icon-sm :pointer))

(cffi:defcfun ("RegisterClassExW" :library user32) win-atom
  (classexw wndclassexw))

(cffi:defcfun ("CreateWindowExW" :library user32) :pointer
  (ex-style dword)
  (class-name wstring)
  (window-name wstring)
  (style dword)
  (x :int)
  (y :int)
  (width :int)
  (height :int)
  (parent :pointer)
  (menu :pointer)
  (instance :pointer)
  (param :pointer))

