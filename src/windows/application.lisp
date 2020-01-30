(in-package :cluiless/windows)

(defclass application (cluiless:application)
  ((windows
     :reader windows
     :initform (make-hash-table))
   (last-id
     :accessor last-id
     :initform 0)))

(cluiless:defbackend :windows cluiless/windows)

(defmethod initialize-instance :before ((instance application) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (cluiless:load-backend-libraries 'user32 'kernel32))

(defmethod cluiless:run ((instance application))
  (trivial-main-thread:with-body-in-main-thread ()
    (float-features:with-float-traps-masked t
      (cluiless:activate instance)
      (cffi:with-foreign-object (m '(:struct msg))
      (do ((status (get-message-w m (cffi:null-pointer) 0 0) (get-message-w m (cffi:null-pointer) 0 0)))
          ((< status 1))
        (translate-message m)
        (dispatch-message-w m))))))

(defmethod cluiless:windows ((instance application))
  (hash-table-values (windows instance)))

(defmethod cluiless:window-by-id ((instance application) id)
  (gethash id (windows instance)))

(defun add-window (instance win)
  (with-slots (windows last-id) instance
    (setf last-id (1+ last-id))
    (setf (gethash last-id windows) win)
    last-id))

(defun remove-window (instance id)
  (with-slots (windows) instance
    (remhash id windows)
    (zerop (hash-table-count windows))))
    
