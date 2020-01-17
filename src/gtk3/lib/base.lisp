(in-package #:cluiless/gtk3)

(cffi:define-foreign-library gtk3
  (t (:default "libgtk-3")))

(cffi:define-foreign-library glib2
  (T (:default "libglib-2.0")))

(cffi:define-foreign-library gio2
  (T (:default "libgio-2.0")))

(cffi:define-foreign-library gmodule2
  (T (:default "libgmodule-2.0")))


