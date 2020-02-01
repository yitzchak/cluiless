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

(cffi:define-foreign-type ns-string ()
  ()
  (:actual-type :pointer)
  (:simple-parser ns-string))

(defmethod cffi:translate-to-foreign (value (type ns-string))
  (declare (ignore type))
  value)

(defmethod cffi:translate-to-foreign ((value string) (type ns-string))
  (declare (ignore type))
  (objc/msg-send "NSString" "stringWithUTF8String:"
    :pointer
    :string value))

(defmethod cffi:translate-from-foreign (value (type ns-string))
  (declare (ignore type))
  (cffi:foreign-string-to-lisp (objc/msg-send value "UTF8String" :pointer) :encoding :utf-8))


