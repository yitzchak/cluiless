(pkg-config-cflags "gtk+-3.0" :optional t)

(c "
#if defined __has_include
#  if __has_include (<gtk/gtk.h>)
#    include <gtk/gtk.h>
#  endif
#endif")

(feature :gtk3 "GTK_MAJOR_VERSION")
