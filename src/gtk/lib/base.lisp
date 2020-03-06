(in-package #:cluiless/gtk)

(cffi:define-foreign-library gtk
  (t (:default "libgtk-3")))

(cffi:define-foreign-library glib
  (t (:default "libglib-2.0")))

(cffi:define-foreign-library gio
  (t (:default "libgio-2.0")))

(cffi:define-foreign-library gmodule
  (t (:default "libgmodule-2.0")))

(cffi:define-foreign-library amtk
  (t (:default "libamtk-5")))

