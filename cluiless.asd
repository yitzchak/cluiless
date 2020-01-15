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
    #:trivial-garbage)
  :components
    ((:module src
      :serial t
      :components
        ((:file "packages")
         (:file "backend")
         (:module lib
          :serial t
          :components
            ((:module gtk3
              :serial t
              :components
                ((:file "base")))))
         (:module gtk3
            :serial t
            :components
              ((:file "backend")))
           (:module darwin
            :serial t
            :components
              ((:file "backend")))
           (:module win32
            :serial t
            :components
              ((:file "backend")))))))
