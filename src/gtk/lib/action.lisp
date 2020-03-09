(in-package #:cluiless/gtk)

(cffi:defcfun ("g_action_get_name" :library gio) :string
  (action object-handle))

(cffi:defcfun ("g_simple_action_new" :library gio) :pointer
  (name :string)
  (parameter-type :pointer))

