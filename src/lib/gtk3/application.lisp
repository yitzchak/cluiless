(in-package #:cluiless/gtk3)

(cffi:defcfun ("gtk_application_new" :library gtk3) :pointer
  (name :string)
  (flags g-application-flags))
