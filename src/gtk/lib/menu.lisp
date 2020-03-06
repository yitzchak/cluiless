(in-package #:cluiless/gtk)

(cffi:defcfun ("g_menu_new" :library gio) :pointer)

(cffi:defcfun ("g_menu_append" :library gio) :void
  (menu :pointer)
  (label :string)
  (detailed-action :string))
