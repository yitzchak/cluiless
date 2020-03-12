(in-package :cluiless/cocoa)

(cffi:defcallback application-should-terminate-after-last-window-closed :boolean ((instance objc-id) (name sel) (application :pointer))
  (declare (ignore instance name application))
  t)

(defclass application (cluiless:application cluiless:action-map)
  ((delegate-class
     :accessor delegate-class
     :allocation :class))
  (:metaclass cluiless:object-metaclass))

(cluiless:defbackend :cocoa cluiless/cocoa)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (cluiless:load-backend-libraries 'objc 'cocoa 'app-kit 'foundation)

  (with-slots (delegate-class handle) instance
    (unless (slot-boundp instance 'delegate-class)
      (setf delegate-class
        (objc/allocate-class-pair "NSObject" "cluilessApplicationDelegate" 0))
      (class/add-protocol delegate-class "NSApplicationDelegate")
      (class/add-method delegate-class "applicationShouldTerminateAfterLastWindowClosed:"
        (cffi:callback application-should-terminate-after-last-window-closed) "c@:@")
      (objc/register-class-pair delegate-class))

    (setf handle (objc/msg-send "NSApplication" "sharedApplication"))

    (objc/msg-send instance "setDelegate:" :pointer
      objc-id (objc/msg-send delegate-class "new" :pointer))))

(defmethod cluiless:run ((instance application))
  (trivial-main-thread:with-body-in-main-thread ()
    (float-features:with-float-traps-masked t
      (cluiless:activate instance)
      (objc/msg-send instance "run" :void))))

(defmethod cluiless:valid-sites ((instance application))
  (list :menu-bar))

(defun append-menu (instance menu definition)
  (case (getf definition :type :action)
    (:action
      (let* ((name (getf definition :name))
             (action (cluiless:find-action instance name))
             (item (objc/msg-send
                    menu
                    "addItemWithTitle:action:keyEquivalent:"
                    :pointer
                    :string (cluiless:label action)
                    :pointer (cffi:null-pointer)
                    :string "")))))
        ; (objc/msg-send item "setTarget:"
        ;   :pointer
        ;   objc-id (objc/msg-send instance "delegate"))))
    ; (:section
    ;   (let ((section (g-menu-new)))
    ;     (dolist (def (getf definition :children))
    ;       (append-menu instance section def))
    ;     (g-menu-append-section menu (getf definition :label) section)))
    (:menu
      (let* ((item (objc/msg-send
                    menu
                    "addItemWithTitle:action:keyEquivalent:"
                    :pointer
                    :string (getf definition :label)
                    :pointer (cffi:null-pointer)
                    :string ""))
             (submenu (objc/msg-send
                        (objc/msg-send "NSMenu" "alloc" :pointer)
                        "initWithTitle:"
                        :pointer
                        :string (getf definition :label))))
        (dolist (def (getf definition :children))
          (append-menu instance submenu def))
        (objc/msg-send item "setSubmenu:" :pointer :pointer submenu)))))

(defmethod cluiless:append-definitions ((instance application) (site (eql :menu-bar)) &rest definitions)
  (let ((main-menu (objc/msg-send "NSApplication" "mainMenu")))
    (dolist (definition definitions)
      (append-menu instance main-menu definition))))

