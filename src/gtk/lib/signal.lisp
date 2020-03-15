(in-package #:cluiless/gtk)

(cffi:defbitfield (g-connect-flags :unsigned-int)
  :after
  :swapped)

(cffi:defcfun ("g_signal_connect_data" :library glib) :unsigned-long
  (instance object-handle)
  (signal :string)
  (handler :pointer)
  (data object-handle)
  (destroy :pointer)
  (flags g-connect-flags))

(cffi:defcfun ("g_signal_handler_disconnect" :library glib) :void
  (instance object-handle)
  (hander-id :unsigned-long))

