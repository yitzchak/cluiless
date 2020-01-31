(in-package :cluiless/cocoa)

(cffi:defbitfield ns-window-style-mask
  (:borderless #x0)
  (:titled #x1)
  (:closable #x2)
  (:miniaturizable #x4)
  (:resizable #x8)
  (:utility-window #x10)
  (:doc-modal-window #x20)
  (:non-activating-panel #x40)
  (:unified-title-and-toolbar #x1000)
  (:hud-window #x2000)
  (:full-screen #x4000)
  (:full-size-content-view #x8000))

(cffi:defbitfield ns-backing-store-type
  (:buffered #x2))

(defobjcfun "initWithContentRect:styleMask:backing:defer:" :pointer
  (content-rect (:struct ns-rect))
  (style-mask ns-window-style-mask)
  (backing ns-backing-store-type)
  (defer :boolean))

(defobjcfun "isVisible" :boolean)

(defobjcfun "setIsVisible:" :void
  (value :boolean))

(defobjcfun "title" ns-string)

(defobjcfun "setText:" :void
  (value ns-string))

