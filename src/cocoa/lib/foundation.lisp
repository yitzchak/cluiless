(in-package #:cluiless/cocoa)

(cffi:defcstruct ns-point
  (:x :double)
  (:y :double))

(cffi:defcstruct ns-size
  (:width :double)
  (:height :double))

(cffi:defcstruct ns-rect
  (:origin (:struct ns-point))
  (:size (:struct ns-size)))

