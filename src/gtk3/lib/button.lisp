(in-package #:cluiless/gtk3)

(cffi:defcfun ("gtk_button_set_image" :library gtk3) :void
  (button object-handle)
  (image :pointer))
