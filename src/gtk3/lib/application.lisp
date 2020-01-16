(in-package #:cluiless/gtk3)

(cffi:defcfun ("gtk_application_new" :library gtk3) :pointer
  (name :string)
  (flags g-application-flags))

(cffi:defcfun ("gtk_application_add_window" :library gtk3) :void
  (application cluiless:object-handle)
  (window :pointer))

(cffi:defcfun ("gtk_application_remove_window" :library gtk3) :void
  (application cluiless:object-handle)
  (window :pointer))


