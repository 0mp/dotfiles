--- x.c.orig	2018-01-16 01:05:12 UTC
+++ x.c
@@ -140,6 +140,9 @@ static DC dc;
 static XWindow xw;
 static XSelection xsel;
 
+extern char *cwd;
+extern char *plumber_cmd;
+
 /* Font Ring Cache */
 enum {
 	FRC_NORMAL,
@@ -512,6 +515,9 @@ xsetsel(char *str, Time t)
 void
 brelease(XEvent *e)
 {
+	pid_t child;
+	char cmd[400];
+
 	if (IS_SET(MODE_MOUSE) && !(e->xbutton.state & forceselmod)) {
 		mousereport(e);
 		return;
@@ -519,6 +525,15 @@ brelease(XEvent *e)
 
 	if (e->xbutton.button == Button2) {
 		xselpaste();
+	} else if (e->xbutton.button == Button3) {
+		switch(child = fork()) {
+			case -1:
+				return;
+			case 0:
+				snprintf(cmd, sizeof(cmd), "%s %s", plumber_cmd, sel.primary);
+				execvp( "sh", (char *const []){ "/bin/sh", "-c", cmd, 0 });
+				exit(127);
+		}
 	} else if (e->xbutton.button == Button1) {
 		if (sel.mode == SEL_READY) {
 			getbuttoninfo(e);
@@ -1417,11 +1432,11 @@ drawregion(int x1, int y1, int x2, int y2)
 		term.dirty[y] = 0;
 
 		specs = term.specbuf;
-		numspecs = xmakeglyphfontspecs(specs, &term.line[y][x1], x2 - x1, x1, y);
+		numspecs = xmakeglyphfontspecs(specs, &TLINE(y)[x1], x2 - x1, x1, y);
 
 		i = ox = 0;
 		for (x = x1; x < x2 && i < numspecs; x++) {
-			new = term.line[y][x];
+			new = TLINE(y)[x];
 			if (new.mode == ATTR_WDUMMY)
 				continue;
 			if (ena_sel && selected(x, y))
@@ -1441,7 +1456,9 @@ drawregion(int x1, int y1, int x2, int y2)
 		if (i > 0)
 			xdrawglyphfontspecs(specs, base, i, ox, y);
 	}
-	xdrawcursor();
+
+	if (term.scr == 0)
+		xdrawcursor();
 }
 
 void
