(in-package #:cluiless/gtk)

(cffi:define-foreign-type action-name ()
  ()
  (:actual-type :string)
  (:simple-parser action-name))

(defmethod cffi:translate-to-foreign ((value symbol) (type action-name))
  (declare (ignore type))
  (cffi:foreign-string-alloc (symbol-name value)))

(defmethod cffi:translate-from-foreign (value (type action-name))
  (declare (ignore type))
  (intern (cffi:foreign-string-to-lisp value) "KEYWORD"))

(defmethod cffi:free-translated-object (pointer (type action-name) param)
  (declare (ignore param))
  (cffi:foreign-string-free pointer))

(cffi:defcfun ("g_action_get_name" :library gio) action-name
  (action object-handle))

(cffi:defcfun ("g_action_get_enabled" :library gio) :boolean
  (action object-handle))

(cffi:defcfun ("g_simple_action_new" :library gio) :pointer
  (name action-name)
  (parameter-type :pointer))

(cffi:defcfun ("g_simple_action_set_enabled" :library gio) :void
  (action object-handle)
  (enabled :boolean))

(cffi:defcfun ("g_action_map_add_action" :library gio) :void
  (action-map object-handle)
  (action object-handle))

(cffi:defcfun ("g_action_map_remove_action" :library gio) :void
  (action-map object-handle)
  (action-name action-name))

(cffi:defcfun ("g_action_map_lookup_action" :library gio) object-handle
  (action-map object-handle)
  (action-name action-name))

