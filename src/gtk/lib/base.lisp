(in-package #:cluiless/gtk)

(cffi:define-foreign-library gtk
  (t (:default "libgtk-3")))

(cffi:define-foreign-library glib
  (T (:default "libglib-2.0")))

(cffi:define-foreign-library gio
  (T (:default "libgio-2.0")))

(cffi:define-foreign-library gmodule
  (T (:default "libgmodule-2.0")))

(cffi:defctype size-t
  #+x86 :uint32
  #+x86-64 :uint64
  #-(or x86-64 x86) :long)


