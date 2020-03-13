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

(def-objc-method nil "orderFrontRegardless" :void)

(def-objc-method nil "makeKeyAndOrderFront:" :void
  (sender :pointer))
