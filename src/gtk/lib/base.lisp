(in-package #:cluiless/gtk)

(cffi:define-foreign-library gtk
  (t (:default "libgtk-4")))

(cffi:define-foreign-library glib
  (T (:default "libglib-2.0")))

(cffi:define-foreign-library gio
  (T (:default "libgio-2.0")))

(cffi:define-foreign-library gmodule
  (T (:default "libgmodule-2.0")))


