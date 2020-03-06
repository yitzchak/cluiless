(in-package #:cluiless/gtk)

(cffi:defcfun ("amtk_init" :library amtk) :void)

(cffi:defcfun ("amtk_finalize" :library amtk) :void)

(cffi:defcfun ("amtk_factory_new_with_default_application" :library amtk) :void)

(cffi:defbitfield (amtk-factory-flags :unsigned-int)
  :ignore-g-action
  :ignore-icon
  :ignore-label
  :ignore-tooltip
  :ignore-accels
  :ignore-accels-for-doc
  :ignore-accels-for-app)
