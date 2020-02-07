(in-package #:cluiless/gtk3)

(cffi:defcfun ("gtk_menu_button_new" :library gtk3) :pointer)

(cffi:defcfun ("gtk_menu_button_set_use_popover" :library gtk3) :void
  (menu-button object-handle)
  (use-popover :boolean))

(cffi:defcfun ("gtk_menu_button_get_use_popover" :library gtk3) :boolean
  (menu-button object-handle))

(cffi:defcfun ("gtk_menu_button_set_menu_model" :library gtk3) :void
  (menu-button object-handle)
  (menu-model :pointer))
