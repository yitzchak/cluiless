(defpackage #:cluiless
  (:use #:alexandria #:cl)
  (:export
     #:*backend-classes*
     #:backend-error
     #:backend
     #:initialize-backend))

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

  
