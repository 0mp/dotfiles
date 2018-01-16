--- config.def.h.orig	2018-01-16 00:02:17 UTC
+++ config.def.h
@@ -1,6 +1,11 @@
 /* See LICENSE file for copyright and license details. */
 
 /*
+ * plumber
+ */
+static char plumber[] = "~/plumb.sh";
+
+/*
  * appearance
  *
  * font: see http://freedesktop.org/software/fontconfig/fontconfig-user.html
@@ -63,7 +68,7 @@ unsigned int cursorthickness = 2;
 static int bellvolume = 0;
 
 /* default TERM value */
-char termname[] = "st-256color";
+char termname[] = "xterm-256color";
 
 /*
  * spaces per tab
@@ -178,6 +183,8 @@ Shortcut shortcuts[] = {
 	{ TERMMOD,              XK_Y,           selpaste,       {.i =  0} },
 	{ TERMMOD,              XK_Num_Lock,    numlock,        {.i =  0} },
 	{ TERMMOD,              XK_I,           iso14755,       {.i =  0} },
+	{ ShiftMask,            XK_Page_Up,     kscrollup,      {.i = -1} },
+	{ ShiftMask,            XK_Page_Down,   kscrolldown,    {.i = -1} },
 };
 
 /*
