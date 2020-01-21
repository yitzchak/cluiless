(in-package #:cluiless/gtk3)

(pkg-config-cflags "gtk+-3.0")

(include "gtk/gtk.h")

(ctype gulong "gulong")

(define "_G_APPLICATION_IS_SERVICE" "G_APPLICATION_IS_SERVICE")
(define "_G_APPLICATION_IS_LAUNCHER" "G_APPLICATION_IS_LAUNCHER")
(define "_G_APPLICATION_HANDLES_COMMAND_LINE" "G_APPLICATION_HANDLES_COMMAND_LINE")
(define "_G_APPLICATION_SEND_ENVIRONMENT" "G_APPLICATION_SEND_ENVIRONMENT")
(define "_G_APPLICATION_NON_UNIQUE" "G_APPLICATION_NON_UNIQUE")
(define "_G_APPLICATION_CAN_OVERRIDE_APP_ID" "G_APPLICATION_CAN_OVERRIDE_APP_ID")
(define "_G_APPLICATION_ALLOW_REPLACEMENT" "G_APPLICATION_ALLOW_REPLACEMENT")
(define "_G_APPLICATION_REPLACE" "G_APPLICATION_REPLACE")

(bitfield (g-application-flags :base-type :unsigned-int)
;  ((:none "G_APPLICATION_FLAGS_NONE"))
  ((:is-service "_G_APPLICATION_IS_SERVICE"))
  ((:is-launcher "_G_APPLICATION_IS_LAUNCHER"))
  ((:handles-command-line "_G_APPLICATION_HANDLES_COMMAND_LINE"))
  ((:send-environment "_G_APPLICATION_SEND_ENVIRONMENT"))
  ((:non-unique "_G_APPLICATION_NON_UNIQUE"))
  ((:can-override-app-id "_G_APPLICATION_CAN_OVERRIDE_APP_ID"))
  ((:allow-replacement "_G_APPLICATION_ALLOW_REPLACEMENT"))
  ((:replace "_G_APPLICATION_REPLACE")))

(define "_G_CONNECT_AFTER" "G_CONNECT_AFTER")
(define "_G_CONNECT_SWAPPED" "G_CONNECT_AFTER")

(bitfield (g-connect-flags :base-type :unsigned-int)
  ((:after "_G_CONNECT_AFTER"))
  ((:swapped "_G_CONNECT_SWAPPED")))

(cenum (gtk-window-type :base-type :unsigned-int)
  ((:toplevel "GTK_WINDOW_TOPLEVEL"))
  ((:popup "GTK_WINDOW_POPUP")))

