(ql:quickload :cluiless)

(defparameter app (cluiless:make-application :name "org.fu.bar"))

(defmethod cluiless:activate ((instance cluiless:application))
  (let ((win (cluiless:make-window :title "Window" :visible t)))
    (cluiless:add-action win (cluiless:make-action :name "about" :label "About"))
    (cluiless:define-site win :primary-menu '("about"))))

(defmethod cluiless:activate ((instance cluiless:action))
  (format *error-output* "~S~%" (cluiless:name instance)))

(cluiless:run app)
  
