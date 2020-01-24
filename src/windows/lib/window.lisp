(in-package #:cluiless/windows)

(cffi:defcstruct wndclassexw :class wnd-class-ex-w
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

(defmethod cffi:translate-to-foreign (value (type wnd-class-ex-w))
  (cffi:foreign-alloc '(:struct wndclassexw)
    :initial-element
      (append (list :size (cffi:foreign-type-size '(:struct wndclassexw))) value)))

(defmethod cffi:free-translated-object (pointer (type wnd-class-ex-w) param)
  (declare (ignore param))
  (cffi:foreign-free pointer))

(cffi:defcfun ("RegisterClassExW" :library user32) win-atom
  (classexw wnd-class-ex-w))

(cffi:defcfun ("CreateWindowExW" :library user32) :pointer
  (ex-style window-style-ex)
  (class-name wstring)
  (window-name wstring)
  (style window-style)
  (x :int)
  (y :int)
  (width :int)
  (height :int)
  (parent :pointer)
  (menu :pointer)
  (instance :pointer)
  (param :pointer))

(cffi:defcfun ("GetWindowTextLengthW" :library user32) :int
  (window object-handle))

(cffi:defcfun ("GetWindowTextW" :library user32) :int
  (window object-handle)
  (buf :pointer)
  (max-count :int))

(cffi:defcfun ("IsWindowVisible" :library user32) :boolean
  (window object-handle))

(cffi:defcfun ("SetWindowTextW" :library user32) :boolean
  (window object-handle)
  (value wstring))

(cffi:defcfun ("ShowWindow" :library user32) :boolean
  (window object-handle)
  (cmd-show show-window-cmd))
