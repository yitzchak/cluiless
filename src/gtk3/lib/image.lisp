(in-package #:cluiless/gtk3)

(cffi:defcenum gtk-icon-size :unsigned-int
  :invalid
  :menu
  :small-toolbar
  :large-toolbar
  :button
  :dnd
  :dialog)

(cffi:defcfun ("gtk_image_new_from_icon_name" :library gtk3) :pointer
  (icon-name :string)
  (size gtk-icon-size))
