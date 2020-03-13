(in-package :cluiless/cocoa)

(def-objc-method "NSMenu" "alloc")

(def-objc-method nil "initWithTitle:" objc-id
  (title ns-string))

(def-objc-property nil "submenu")

(def-objc-method nil "addItemWithTitle:action:keyEquivalent:" objc-id
  (title ns-string)
  (action sel)
  (key-equivalent ns-string))

(def-objc-property nil "target")


