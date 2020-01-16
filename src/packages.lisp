(defpackage #:cluiless
  (:use #:alexandria #:cl)
  (:export
     #:backend
     #:*backend-classes*
     #:backend-error
     #:initialize-backend
     #:object
     #:object-handle))

(defpackage #:cluiless/darwin
  (:use #:alexandria #:cl)
  (:export
    #:backend))

(defpackage #:cluiless/win32
  (:use #:alexandria #:cl)
  (:export
    #:backend))

(defpackage #:cluiless/gtk3
  (:use #:alexandria #:cl)
  (:export
    #:backend))

  
