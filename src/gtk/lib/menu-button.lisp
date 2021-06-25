(in-package #:cluiless/gtk)

(cffi:defcfun ("gtk_menu_button_new" :library gtk) :pointer)

(cffi:defcfun ("gtk_menu_button_set_use_popover" :library gtk) :void
  (menu-button object-handle)
  (use-popover :boolean))

(cffi:defcfun ("gtk_menu_button_get_use_popover" :library gtk) :boolean
  (menu-button object-handle))

(cffi:defcfun ("gtk_menu_button_set_menu_model" :library gtk) :void
  (menu-button object-handle)
  (menu-model :pointer))

(cffi:defcfun ("gtk_menu_button_set_icon_name" :library gtk) :void
  (button object-handle)
  (image :string))
