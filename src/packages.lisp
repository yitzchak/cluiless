(defpackage #:cluiless
  (:use #:alexandria #:cl)
  (:export
     #:*backend-classes*
     #:backend-error
     #:backend
     #:initialize-backend))

(defpackage #:cluiless/lib/gtk3
  (:use #:alexandria #:cl)
  (:export
    #:gtk3))

(defpackage #:cluiless/darwin
  (:use #:alexandria #:cl)
  (:export
    #:backend))

(defpackage #:cluiless/win32
  (:use #:alexandria #:cl)
  (:export
    #:backend))

(defpackage #:cluiless/gtk3
  (:use #:alexandria #:cl #:cluiless/lib/gtk3)
  (:export
    #:backend))

  
