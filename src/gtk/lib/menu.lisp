(in-package #:cluiless/gtk)

(cffi:defcfun ("g_menu_new" :library gio) :pointer)

(cffi:defcfun ("g_menu_append" :library gio) :void
  (menu :pointer)
  (label :string)
  (detailed-action :string))
  
(cffi:defcfun ("g_menu_append_section" :library gio) :void
  (menu :pointer)
  (label :string)
  (section :pointer))

(cffi:defcfun ("g_menu_append_submenu" :library gio) :void
  (menu :pointer)
  (label :string)
  (section :pointer))
    
