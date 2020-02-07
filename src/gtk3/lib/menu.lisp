(in-package #:cluiless/gtk3)

(cffi:defcfun ("g_menu_new" :library gio2) :pointer)

(cffi:defcfun ("g_menu_append" :library gio2) :void
  (menu :pointer)
  (label :string)
  (detailed-action :string))
