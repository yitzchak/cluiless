(ql:quickload :cluiless)

(defparameter app (cluiless:make-application :name "org.fu.bar"))

(defmethod cluiless:activate ((instance cluiless:application))
  (declare (ignore instance))
  (cluiless:make-window :title "Window" :visible t))

(cluiless:run app)
  
