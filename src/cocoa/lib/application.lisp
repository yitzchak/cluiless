(in-package :cluiless/cocoa)

(cffi:defcenum ns-application-activation-policy
  :regular
  :accessory
  :prohibited)

(def-objc-method nil "activateIgnoringOtherApps:" :void
  (flag :bool))

(def-objc-method "NSApplication" "sharedApplication" objc-id)
