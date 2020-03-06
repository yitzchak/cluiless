(in-package #:cluiless/gtk)

(cffi:defcfun ("gtk_header_bar_new" :library gtk) :pointer)

(cffi:defcfun ("gtk_header_bar_set_title" :library gtk) :void
  (bar object-handle)
  (title :string))

(cffi:defcfun ("gtk_header_bar_get_title" :library gtk) :string
  (bar object-handle))

(cffi:defcfun ("gtk_header_bar_set_subtitle" :library gtk) :void
  (bar object-handle)
  (title :string))

(cffi:defcfun ("gtk_header_bar_get_subtitle" :library gtk) :string
  (bar object-handle))

(cffi:defcfun ("gtk_header_bar_set_has_subtitle" :library gtk) :void
  (bar object-handle)
  (setting :boolean))

(cffi:defcfun ("gtk_header_bar_get_has_subtitle" :library gtk) :boolean
  (bar object-handle))

(cffi:defcfun ("gtk_header_bar_pack_start" :library gtk) :void
  (bar object-handle)
  (child object-handle))

(cffi:defcfun ("gtk_header_bar_pack_end" :library gtk) :void
  (bar object-handle)
  (child object-handle))

(cffi:defcfun ("gtk_header_bar_set_show_close_button" :library gtk) :void
  (bar object-handle)
  (setting :boolean))

(cffi:defcfun ("gtk_header_bar_get_show_close_button" :library gtk) :boolean
  (bar object-handle))


