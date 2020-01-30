(in-package #:cluiless/windows)

(defparameter +color-active-border+ 10)
(defparameter +color-active-caption+ 2)
(defparameter +color-app-workspace+ 12)
(defparameter +color-background+ 1)
(defparameter +color-btn-face+ 15)
(defparameter +color-btn-shadow+ 16)
(defparameter +color-btn-text+ 18)
(defparameter +color-caption-text+ 9)
(defparameter +color-gray-text+ 17)
(defparameter +color-highlight+ 13)
(defparameter +color-highlight-text+ 14)
(defparameter +color-inactive-border+ 11)
(defparameter +color-inactive-caption+ 3)
(defparameter +color-menu+ 4)
(defparameter +color-menu-text+ 7)
(defparameter +color-scroll-bar+ 0)
(defparameter +color-window+ 5)
(defparameter +color-window-frame+ 6)
(defparameter +color-window-text+ 8)

(defparameter +c-app-starting+ (cffi:make-pointer 32650))
(defparameter +c-arrow+ (cffi:make-pointer 32512))
(defparameter +c-cross+ (cffi:make-pointer 32515))
(defparameter +c-hand+ (cffi:make-pointer 32649))
(defparameter +c-help+ (cffi:make-pointer 32651))
(defparameter +c-i-beam+ (cffi:make-pointer 32513))
(defparameter +c-no+ (cffi:make-pointer 32648))
(defparameter +c-size-all+ (cffi:make-pointer 32646))
(defparameter +c-size-nesw+ (cffi:make-pointer 32643))
(defparameter +c-size-ns+ (cffi:make-pointer 32645))
(defparameter +c-size-nwse+ (cffi:make-pointer 32642))
(defparameter +c-size-we+ (cffi:make-pointer 32644))
(defparameter +c-up-arrow+ (cffi:make-pointer 32516))
(defparameter +c-wait+ (cffi:make-pointer 32514))

(defparameter +cw-use-default+ -2147483648)

(cffi:defbitfield (class-style :unsigned-int)
  :vredraw
  :hredraw
  (:double-clicks #x8)
  (:own-dc #x20)
  :class-dc
  :parent-dc
  (:no-close #x200)
  (:save-bits #x800)
  :byte-align-client
  :byte-align-window
  :global-class
  (:drop-shadow #x20000))

(cffi:defbitfield (window-style-ex :uint32)
  (:left #x0)
  (:ltr-reading #x0)
  (:right-scroll-bar #x0)
  :dlg-modal-frame
  (:no-parent-notify #x4)
  :top-most
  :accept-files
  :transparent
  :mdi-child
  :tool-window
  :window-edge
  :client-edge
  :context-help
  (:right #x1000)
  :rtl-reading
  :left-scroll-bar
  (:control-parent #x10000)
  :static-edge
  :app-window
  :layered
  :no-inherit-layout
  :no-redirection-bitmap
  :layout-rtl
  (:composited #x2000000)
  (:no-activate #x8000000)
  (:overlapped-window #x300)
  (:palette-window #x188))

(cffi:defbitfield (window-style :uint32)
  (:border #x800000)
  (:caption #xC00000)
  (:child #x40000000)
  (:child-window #x40000000)
  (:clip-children #x2000000)
  (:clip-siblings #x4000000)
  (:disabled #x8000000)
  (:dlg-frame #x400000)
  (:group #x20000)
  (:hscroll #x100000)
  (:iconic #x20000000)
  (:maximize #x1000000)
  (:maximize-box #x10000)
  (:minimize #x20000000)
  (:minimize-box #x20000)
  (:overlapped #x0)
  (:overlapped-window #xCF0000)
  (:popup #x0)
  (:popup-window #x880000)
  (:sizebox #x40000)
  (:sysmenu #x80000)
  (:tabstop #x10000)
  (:thick-frame #x40000)
  (:tiled #x0)
  (:tiled-window #xCF0000)
  (:visible #x10000000)
  (:vscroll #x200000))

(cffi:defcenum (show-window-cmd :int)
  (:force-minimize 11)
  (:hide 0)
  (:maximize 3)
  (:minimize 6)
  (:restore 9)
  (:show 5)
  (:show-default 10)
  (:show-maximized 3)
  (:show-minimized 2)
  (:show-minimized-no-activate 7)
  (:show-no-activate 8)
  (:show-normal-no-activate 4)
  (:show-normal 1))

(cffi:defcstruct wndclassexw
  (:size :uint)
  (:style class-style)
  (:wnd-proc :pointer)
  (:cls-extra :int)
  (:wnd-extra :int)
  (:instance :pointer)
  (:icon :pointer)
  (:cursor :pointer)
  (:background :pointer)
  (:menu-name wstring)
  (:class-name wstring)
  (:icon-sm :pointer))

(cffi:define-foreign-type wnd-class-ex-w ()
  ()
  (:actual-type :pointer)
  (:simple-parser wnd-class-ex-w))

(defmethod cffi:translate-to-foreign (value (type wnd-class-ex-w))
  (cffi:foreign-alloc '(:struct wndclassexw)
    :initial-element
      (append (list :size (cffi:foreign-type-size '(:struct wndclassexw))) value)))

(defmethod cffi:free-translated-object (pointer (type wnd-class-ex-w) param)
  (declare (ignore param))
  (cffi:foreign-free pointer))

(cffi:defcfun ("RegisterClassExW" :library user32) :int16
  (classexw wnd-class-ex-w))

(cffi:defcfun ("CreateWindowExW" :library user32) :pointer
  (ex-style window-style-ex)
  (class-name wstring)
  (window-name wstring)
  (style window-style)
  (x :int)
  (y :int)
  (width :int)
  (height :int)
  (parent :pointer)
  (menu :pointer)
  (instance :pointer)
  (param :pointer))

(cffi:defcfun ("DefWindowProcW" :library user32) :long
  (window object-handle)
  (msg :uint)
  (wparam :ulong)
  (lparam :long))

(cffi:defcfun ("GetWindowTextLengthW" :library user32) :int
  (window object-handle))

(cffi:defcfun ("GetWindowTextW" :library user32) :int
  (window object-handle)
  (buf :pointer)
  (max-count :int))

(cffi:defcfun ("IsWindowVisible" :library user32) :boolean
  (window object-handle))

(cffi:defcfun ("SetWindowTextW" :library user32) :boolean
  (window object-handle)
  (value wstring))

(cffi:defcfun ("ShowWindow" :library user32) :boolean
  (window object-handle)
  (cmd-show show-window-cmd))

(cffi:defcfun ("LoadCursorW" :library user32) :pointer
  (instance :pointer)
  (cursor-name wstring))
