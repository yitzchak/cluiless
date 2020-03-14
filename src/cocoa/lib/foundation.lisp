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

(def-objc-method "NSString" "stringWithUTF8String:" :pointer
  (value :string))

(def-objc-method nil "UTF8String" :string)

(defmethod cffi:translate-to-foreign (value (type ns-string))
  (declare (ignore type))
  value)

(defmethod cffi:translate-to-foreign ((value string) (type ns-string))
  (declare (ignore type))
  (ns-string/string-with-utf8-string= value))

(defmethod cffi:translate-from-foreign (value (type ns-string))
  (declare (ignore type))
  (cffi:foreign-string-to-lisp (~/utf8-string value) :encoding :utf-8))

(def-objc-method nil "new")

(def-objc-method nil "release")

(def-objc-method nil "retain")

(defmethod cluiless:release ((backend (eql :cocoa)) handle)
  (~/release handle))
