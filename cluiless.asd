(asdf:defsystem #:cluiless
  :description "A native GUI for Common Lisp."
  :version "0.1"
  :author "Tarn W. Burton"
  :license "MIT"
  :defsystem-depends-on (:cffi-grovel)
  :depends-on (
    #:alexandria
    #:cffi
    #:closer-mop
    #:trivial-garbage
    #:trivial-main-thread)
  :components
    ((:module src
      :serial t
      :components
        ((:file "packages")
         (:file "application")
         (:module gtk3
            :serial t
            :components
              ((:module lib
                :serial t
                :components
                  ((:file "base")
                   (:cffi-grovel-file "grovel")
                   (:file "application")))
               (:file "application")))
           (:module cocoa
            :serial t
            :components
              ((:file "application")))
           (:module win32
            :serial t
            :components
              ((:file "application")))))))
