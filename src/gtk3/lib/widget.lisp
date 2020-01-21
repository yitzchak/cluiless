(in-package #:cluiless/gtk3)

(cffi:defcfun ("gtk_widget_show_all" :library gtk3) :void
  (widget object-handle))

(cffi:defcfun ("gtk_widget_get_visible" :library gtk3) :boolean
  (widget object-handle))

(cffi:defcfun ("gtk_widget_set_visible" :library gtk3) :void
  (widget object-handle)
  (value :boolean))


