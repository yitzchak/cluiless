(in-package #:cluiless/gtk)

(cffi:defcfun ("gtk_widget_show_all" :library gtk) :void
  (widget object-handle))

(cffi:defcfun ("gtk_widget_get_visible" :library gtk) :boolean
  (widget object-handle))

(cffi:defcfun ("gtk_widget_set_visible" :library gtk) :void
  (widget object-handle)
  (value :boolean))


