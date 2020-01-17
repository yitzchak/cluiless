(in-package #:cluiless/gtk3)

(cffi:defcfun ("g_signal_connect_data" :library glib2) gulong
  (instance object-handle)
  (signal :string)
  (handler :pointer)
  (data :pointer)
  (destroy :pointer)
  (flags g-connect-flags))

(cffi:defcfun ("g_signal_handler_disconnect" :library glib2) :void
  (instance object-handle)
  (hander-id gulong))

