(in-package #:cluiless/gtk)

(cffi:defcenum gtk-icon-size :unsigned-int
  :invalid
  :menu
  :small-toolbar
  :large-toolbar
  :button
  :dnd
  :dialog)

(cffi:defcfun ("gtk_image_new_from_icon_name" :library gtk) :pointer
  (icon-name :string)
  (size gtk-icon-size))
