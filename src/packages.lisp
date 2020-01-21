(defpackage #:cluiless
  (:use #:alexandria #:cl)
  (:export
     #:backend-error
     #:application
     #:run
     #:activate
     #:make-application
     #:make-window
     #:ui-metaclass
     #:defbackend
     #:visible
     #:title
     #:window))

(defpackage #:cluiless/cocoa
  (:use #:alexandria #:cl)
  (:export
    :application))

(defpackage #:cluiless/windows
  (:use #:alexandria #:cl)
  (:export
    :application))

(defpackage #:cluiless/gtk3
  (:use #:alexandria #:cl)
  (:export
    :application
    :window))

  
