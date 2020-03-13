(in-package :cluiless/cocoa)

(cffi:defcenum ns-application-activation-policy
  :regular
  :accessory
  :prohibited)

(def-objc-method nil "activateIgnoringOtherApps:" :void
  (flag :bool))

(def-objc-method "NSApplication" "sharedApplication")

(def-objc-property nil "activationPolicy" ns-application-activation-policy :bool)

(def-objc-property nil "delegate")

(def-objc-property nil "mainMenu")

(def-objc-method nil "run" :void)

(def-objc-method nil "keyWindow")
