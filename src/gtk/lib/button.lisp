(in-package #:cluiless/gtk)

(cffi:defcfun ("gtk_button_set_image" :library gtk) :void
  (button object-handle)
  (image :pointer))
