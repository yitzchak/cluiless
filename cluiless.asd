(asdf:defsystem #:cluiless
  :description "A native GUI for Common Lisp."
  :version "0.1"
  :author "Tarn W. Burton"
  :license "MIT"
  :depends-on
    (#:alexandria
     #:cffi
     #:closer-mop
     #:float-features
     #:trivial-garbage
     #:trivial-main-thread)
  :components
    ((:module src
      :serial t
      :components
        ((:file "package")
         (:file "core")
         (:file "application")
         (:file "widget")
         (:file "window")
         (:module gtk3
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
                 (:file "application")
                 (:file "widget")
                 (:file "window")))
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
                 (:file "objective-c")))
             (:file "application")))
         (:module windows
          :serial t
          :components
            ((:file "package")
             (:module lib
              :serial t
              :components
                ((:file "base")
                 (:file "object")
                 (:file "kernel")
                 (:file "message")
                 (:file "window")))
             (:file "application")
             (:file "window")))))))

