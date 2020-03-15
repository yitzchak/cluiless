(in-package #:cluiless/gtk)

(cffi:defcfun ("gtk_button_new" :library gtk) :pointer)

(cffi:defcfun ("gtk_button_new_with_label" :library gtk) :pointer
  (label :string))

(cffi:defcfun ("gtk_button_new_from_icon_name" :library gtk) :pointer
  (icon-name :string)
  (size gtk-icon-size))

(cffi:defcfun ("gtk_button_set_image" :library gtk) :void
  (button object-handle)
  (image :pointer))

(cffi:defcfun ("gtk_button_set_label" :library gtk) :void
  (button object-handle)
  (label :string))

