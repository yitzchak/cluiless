(asdf:defsystem #:cluiless
  :description "A native GUI for Common Lisp."
  :version "0.1"
  :author "Tarn W. Burton"
  :license "MIT"
  :depends-on
    (#:alexandria
     #:cffi
     #:cffi-libffi
     #:closer-mop
     #:float-features
     #:trivial-garbage
     #:trivial-main-thread)
  :components
    ((:module src
      :serial t
      :components
        ((:file "package")
         (:file "object")
         (:file "action")
         (:file "action-map")
         (:file "application")
         (:file "widget")
         (:file "window")
         (:module gtk
          :if-feature :unix
          :serial t
          :components
            ((:file "package")
             (:module lib
              :serial t
              :components
                ((:file "base")
                 (:file "object")
                 (:file "glib")
                 (:file "signal")
                 (:file "action")
                 (:file "image")
                 (:file "menu")
                 (:file "button")
                 (:file "menu-button")
                 (:file "application")
                 (:file "header-bar")
                 (:file "widget")
                 (:file "window")))
             (:file "action")
             (:file "application")
             (:file "window")))
         (:module cocoa
          :serial t
          :components
            ((:file "package")
             (:module lib
              :serial t
              :components
                ((:file "base")
                 (:file "objective-c")
                 (:file "foundation")
                 (:file "window")))
             (:file "application")
             (:file "window")))
         (:module windows
          :serial t
          :components
            ((:file "package")
             (:module lib
              :serial t
              :components
                ((:file "base")
                 (:file "kernel")
                 (:file "message")
                 (:file "window")))
             (:file "application")
             (:file "window")))))))

