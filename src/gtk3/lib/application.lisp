(in-package #:cluiless/gtk3)

(cffi:defbitfield (g-application-flags :unsigned-int)
  :is-service
  :is-launcher
  :handles-open
  :handles-command-line
  :send-environment
  :non-unique
  :can-override-app-id
  :allow-replacement
  :replace)

(cffi:defcfun ("g_application_run" :library glib2) :int
  (application object-handle)
  (argc :int)
  (argv :pointer))

(cffi:defcfun ("gtk_application_new" :library gtk3) :pointer
  (name :string)
  (flags g-application-flags))

(cffi:defcfun ("gtk_application_add_window" :library gtk3) :void
  (application object-handle)
  (window :pointer))

(cffi:defcfun ("gtk_application_remove_window" :library gtk3) :void
  (application object-handle)
  (window :pointer))

(cffi:defcfun ("gtk_application_get_windows" :library gtk3) g-list-object-handles
  (application object-handle))

(cffi:defcfun ("gtk_application_get_window_by_id" :library gtk3) object-handle
  (application object-handle)
  (id :unsigned-int))

