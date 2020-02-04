(in-package #:cluiless/gtk3)

(cffi:defcfun ("gtk_header_bar_new" :library gtk3) :pointer)

(cffi:defcfun ("gtk_header_bar_set_title" :library gtk3) :void
  (bar object-handle)
  (title :string))

(cffi:defcfun ("gtk_header_bar_get_title" :library gtk3) :string
  (bar object-handle))

(cffi:defcfun ("gtk_header_bar_set_subtitle" :library gtk3) :void
  (bar object-handle)
  (title :string))

(cffi:defcfun ("gtk_header_bar_get_subtitle" :library gtk3) :string
  (bar object-handle))

(cffi:defcfun ("gtk_header_bar_set_has_subtitle" :library gtk3) :void
  (bar object-handle)
  (setting :boolean))

(cffi:defcfun ("gtk_header_bar_get_has_subtitle" :library gtk3) :boolean
  (bar object-handle))

(cffi:defcfun ("gtk_header_bar_pack_start" :library gtk3) :void
  (bar object-handle)
  (child object-handle))

(cffi:defcfun ("gtk_header_bar_pack_end" :library gtk3) :void
  (bar object-handle)
  (child object-handle))

(cffi:defcfun ("gtk_header_bar_set_show_close_button" :library gtk3) :void
  (bar object-handle)
  (setting :boolean))

(cffi:defcfun ("gtk_header_bar_get_show_close_button" :library gtk3) :boolean
  (bar object-handle))


