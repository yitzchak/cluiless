(in-package #:cluiless/windows)

(include "windows.h")

(ctype win-atom "ATOM")
(ctype word "WORD")
(ctype dword "DWORD")

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

