(in-package #:cluiless/gtk)

(cffi:defcfun ("g_action_get_name" :library gio) :string
  (action object-handle))

(cffi:defcfun ("g_action_get_enabled" :library gio) :boolean
  (action object-handle))

(cffi:defcfun ("g_simple_action_new" :library gio) :pointer
  (name :string)
  (parameter-type :pointer))

(cffi:defcfun ("g_simple_action_set_enabled" :library gio) :void
  (action object-handle)
  (enabled :boolean))

(cffi:defcfun ("g_action_map_add_action" :library gio) :void
  (action-map object-handle)
  (action object-handle))

(cffi:defcfun ("g_action_map_remove_action" :library gio) :void
  (action-map object-handle)
  (action-name :string))

(cffi:defcfun ("g_action_map_lookup_action" :library gio) object-handle
  (action-map object-handle)
  (action-name :string))

