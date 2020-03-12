(ql:quickload :cluiless)

(defparameter app (cluiless:make-application :name "org.fu.bar"))

(defmethod cluiless:activate ((app cluiless:application))
  (let ((win (cluiless:make-window :title "Window" :visible t)))
    (cluiless:add-action win (cluiless:make-action :name :open :label "Open"))
    (cluiless:add-action win (cluiless:make-action :name :about :label "About Simple"))
    (cond
      ((cluiless:valid-site-p app :menu-bar)
        (cluiless:append-definitions
          win :menu-bar
          '(:type :menu :label "Simple" :children (:type :action :name :about))))
      ((cluiless:valid-site-p win :primary-menu)
        (cluiless:append-definitions win :primary-menu '(:type :action :name :about)))
      ((cluiless:valid-site-p win :menu-bar)
        (cluiless:append-definitions
          win :menu-bar
          '(:type :menu :label "File" :children (:type :action :name :open))
          '(:type :menu :label "Help" :children (:type :action :name :about)))))))

(defmethod cluiless:activate-action ((name (eql :about)) instance parameter)
  (declare (ignore instance parameter))
  (format *error-output* "~S~%" name))

(cluiless:run app)
  
