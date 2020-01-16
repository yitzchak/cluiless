(in-package #:cluiless/gtk3)

(pkg-config-cflags "gtk+-3.0")

(include "gtk/gtk.h")

(cenum (g-application-flags :base-type :unsigned-int)
  ((:none "G_APPLICATION_FLAGS_NONE"))
  ((:is-service "G_APPLICATION_IS_SERVICE"))
  ((:is-launcher "G_APPLICATION_IS_LAUNCHER"))
  ((:handles-command-line "G_APPLICATION_HANDLES_COMMAND_LINE"))
  ((:send-environment "G_APPLICATION_SEND_ENVIRONMENT"))
  ((:non-unique "G_APPLICATION_NON_UNIQUE"))
  ((:can-override-app-id "G_APPLICATION_CAN_OVERRIDE_APP_ID"))
  ((:allow-replacement "G_APPLICATION_ALLOW_REPLACEMENT"))
  ((:replace "G_APPLICATION_REPLACE")))
