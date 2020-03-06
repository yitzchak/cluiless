(in-package #:cluiless/gtk)

(cffi:defcenum (gtk-window-type :unsigned-int)
  :toplevel
  :popup)

(cffi:defcfun ("gtk_application_window_new" :library gtk) :pointer
  (application object-handle))

(cffi:defcfun ("gtk_window_new" :library gtk) :pointer
  (flags gtk-window-type))

(cffi:defcfun ("gtk_window_get_title" :library gtk) :string
  (window object-handle))

(cffi:defcfun ("gtk_window_set_title" :library gtk) :void
  (window object-handle)
  (title :string))

(cffi:defcfun ("gtk_window_set_titlebar" :library gtk) :void
  (window object-handle)
  (titlebar object-handle))

