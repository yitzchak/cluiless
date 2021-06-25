(in-package #:cluiless/gtk)

(cffi:defcfun ("gtk_button_set_icon_name" :library gtk) :void
  (button object-handle)
  (image :string))
