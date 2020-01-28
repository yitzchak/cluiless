(in-package #:cluiless/windows)

(include "windows.h")

(ctype dword "DWORD")
(ctype lparam "LPARAM")
(ctype lresult "LRESULT")
(ctype win-atom "ATOM")
(ctype word "WORD")
(ctype wparam "WPARAM")

(bitfield (class-style :base-type :unsigned-int)
  ((:byte-align-client "CS_BYTEALIGNCLIENT"))
  ((:byte-align-window "CS_BYTEALIGNWINDOW"))
  ((:class-dc "CS_CLASSDC"))
  ((:double-clicks "CS_DBLCLKS"))
  ((:drop-shadow "CS_DROPSHADOW"))
  ((:global-class "CS_GLOBALCLASS"))
  ((:hredraw "CS_HREDRAW"))
  ((:no-close "CS_NOCLOSE"))
  ((:own-dc "CS_OWNDC"))
  ((:parent-dc "CS_PARENTDC"))
  ((:save-bits "CS_SAVEBITS"))
  ((:vredraw "CS_VREDRAW")))

(bitfield (window-style-ex :base-type :uint32)
  ((:accept-files "WS_EX_ACCEPTFILES"))
  ((:app-window "WS_EX_APPWINDOW"))
  ((:client-edge "WS_EX_CLIENTEDGE"))
  ((:composited "WS_EX_COMPOSITED"))
  ((:context-help "WS_EX_CONTEXTHELP"))
  ((:control-parent "WS_EX_CONTROLPARENT"))
  ((:dlg-modal-fram "WS_EX_DLGMODALFRAME"))
  ((:layered "WS_EX_LAYERED"))
  ((:layout-rtl "WS_EX_LAYOUTRTL"))
  ((:left "WS_EX_LEFT"))
  ((:left-scroll-bar "WS_EX_LEFTSCROLLBAR"))
  ((:ltr-reading "WS_EX_LTRREADING"))
  ((:mdi-child "WS_EX_MDICHILD"))
  ((:no-activate "WS_EX_NOACTIVATE"))
  ((:no-inherit-layour "WS_EX_NOINHERITLAYOUT"))
  ((:no-parent-notify "WS_EX_NOPARENTNOTIFY"))
;  ((:no-redirection-bitmap "WS_EX_NOREDIRECTIONBITMAP"))
  ((:overlapped-window "WS_EX_OVERLAPPEDWINDOW"))
  ((:pallete-window "WS_EX_PALETTEWINDOW"))
  ((:right "WS_EX_RIGHT"))
  ((:right-scroll-bar "WS_EX_RIGHTSCROLLBAR"))
  ((:rtl-reading "WS_EX_RTLREADING"))
  ((:static-edge "WS_EX_STATICEDGE"))
  ((:tool-window "WS_EX_TOOLWINDOW"))
  ((:top-most "WS_EX_TOPMOST"))
  ((:transparent "WS_EX_TRANSPARENT"))
  ((:window-edge "WS_EX_WINDOWEDGE")))

(bitfield (window-style :base-type :uint32)
  ((:border "WS_BORDER"))
  ((:caption "WS_CAPTION"))
  ((:child "WS_CHILD"))
  ((:child-window "WS_CHILDWINDOW"))
  ((:clip-children "WS_CLIPCHILDREN"))
  ((:clip-siblings "WS_CLIPSIBLINGS"))
  ((:disabled "WS_DISABLED"))
  ((:dlg-frame "WS_DLGFRAME"))
  ((:group "WS_GROUP"))
  ((:hscroll "WS_HSCROLL"))
  ((:iconic "WS_ICONIC"))
  ((:maximize "WS_MAXIMIZE"))
  ((:maximize-box "WS_MAXIMIZEBOX"))
  ((:minimize "WS_MINIMIZE"))
  ((:minimize-box "WS_MINIMIZEBOX"))
  ((:overlapped "WS_OVERLAPPED"))
  ((:overlapped-window "WS_OVERLAPPEDWINDOW"))
  ((:popup "WS_POPUP"))
  ((:popup-window "WS_POPUPWINDOW"))
  ((:sizebox "WS_SIZEBOX"))
  ((:sysmenu "WS_SYSMENU"))
  ((:tabstop "WS_TABSTOP"))
  ((:thick-frame "WS_THICKFRAME"))
  ((:tiled "WS_TILED"))
  ((:tiled-window "WS_TILEDWINDOW"))
  ((:visible "WS_VISIBLE"))
  ((:vscroll "WS_VSCROLL")))

(constantenum (show-window-cmd :base-type :int)
  ((:force-minimize "SW_FORCEMINIMIZE"))
  ((:hide "SW_HIDE"))
  ((:maximize "SW_MAXIMIZE"))
  ((:minimize "SW_MINIMIZE"))
  ((:restore "SW_RESTORE"))
  ((:show "SW_SHOW"))
  ((:show-default "SW_SHOWDEFAULT"))
  ((:show-maximized "SW_SHOWMAXIMIZED"))
  ((:show-minimized "SW_SHOWMINIMIZED"))
  ((:show-minimized-no-activate "SW_SHOWMINNOACTIVE"))
  ((:show-no-activate "SW_SHOWNA"))
  ((:show-normal-no-activate "SW_SHOWNOACTIVATE"))
  ((:show-normal "SW_SHOWNORMAL")))

(constant (+wm-destroy+ "WM_DESTROY"))

(constant (+color-active-border+ "COLOR_ACTIVEBORDER"))
(constant (+color-active-caption+ "COLOR_ACTIVECAPTION"))
(constant (+color-app-workspace+ "COLOR_APPWORKSPACE"))
(constant (+color-background+ "COLOR_BACKGROUND"))
(constant (+color-btn-face+ "COLOR_BTNFACE"))
(constant (+color-btn-shadow+ "COLOR_BTNSHADOW"))
(constant (+color-btn-text+ "COLOR_BTNTEXT"))
(constant (+color-caption-text+ "COLOR_CAPTIONTEXT"))
(constant (+color-gray-text+ "COLOR_GRAYTEXT"))
(constant (+color-highlight+ "COLOR_HIGHLIGHT"))
(constant (+color-highlight-text+ "COLOR_HIGHLIGHTTEXT"))
(constant (+color-inactive-border+ "COLOR_INACTIVEBORDER"))
(constant (+color-inactive-caption+ "COLOR_INACTIVECAPTION"))
(constant (+color-menu+ "COLOR_MENU"))
(constant (+color-menu-text+ "COLOR_MENUTEXT"))
(constant (+color-scroll-bar+ "COLOR_SCROLLBAR"))
(constant (+color-window+ "COLOR_WINDOW"))
(constant (+color-window-frame+ "COLOR_WINDOWFRAME"))
(constant (+color-window-text+ "COLOR_WINDOWTEXT"))

(constant (+c-app-starting+ "IDC_APPSTARTING"))
(constant (+c-arrow+ "IDC_ARROW"))
(constant (+c-cross+ "IDC_CROSS"))
(constant (+c-hand+ "IDC_HAND"))
(constant (+c-help+ "IDC_HELP"))
(constant (+c-i-beam+ "IDC_IBEAM"))
(constant (+c-no+ "IDC_NO"))
(constant (+c-size-all+ "IDC_SIZEALL"))
(constant (+c-size-nesw+ "IDC_SIZENESW"))
(constant (+c-size-ns+ "IDC_SIZENS"))
(constant (+c-size-nwse+ "IDC_SIZENWSE"))
(constant (+c-size-we+ "IDC_SIZEWE"))
(constant (+c-up-arrow+ "IDC_UPARROW"))
(constant (+c-wait+ "DC_WAIT"))

