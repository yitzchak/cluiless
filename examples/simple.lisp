(ql:quickload :cluiless)

(defparameter app (cluiless:make-application :name "org.fu.bar"))

(defmethod cluiless:activate ((app cluiless:application))
  (let ((win (cluiless:make-window :title "Window" :visible t)))
    (cluiless:add-action (cluiless:make-action :name :about :label "About Simple" :target :application))
    (cluiless:add-action (cluiless:make-action :name :open :label "Open" :target :window))
    (cluiless:add-action-sink app (cluiless:make-action-sink :name :about))
    (cluiless:add-action-sink win (cluiless:make-action-sink :name :open))
    (cond
      ((cluiless:valid-site-p app :menu-bar)
        (cluiless:append-definitions
          app :menu-bar
          '(:type :menu :label "Simple" :children ((:type :action :name :about)))
          '(:type :menu :label "File" :children ((:type :action :name :open)))))
      ((cluiless:valid-site-p win :menu)
        (cluiless:append-definitions win :menu '(:type :action :name :about)))
      ((cluiless:valid-site-p win :menu-bar)
        (cluiless:append-definitions
          win :menu-bar
          '(:type :menu :label "File" :children ((:type :action :name :open)))
          '(:type :menu :label "Help" :children ((:type :action :name :about))))))
    (when (cluiless:valid-site-p win :tool-bar)
      (cluiless:append-definitions
        win :tool-bar
        '(:type :action :name :open)))))

(defmethod cluiless:activate-action ((name (eql :about)) (instance cluiless:action-sink) parameter)
  (declare (ignore instance parameter))
  (format *error-output* "~S~%" name))

(defmethod cluiless:activate-action ((name (eql :open)) (instance cluiless:action-sink) parameter)
  (declare (ignore instance parameter))
  (format *error-output* "~S~%" name))

(cluiless:run app)
  
