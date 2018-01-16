--- st.c.orig	2018-01-16 00:19:53 UTC
+++ st.c
@@ -128,6 +128,8 @@ typedef struct {
 /* function definitions used in config.h */
 static void clipcopy(const Arg *);
 static void clippaste(const Arg *);
+static void kscrolldown(const Arg *);
+static void kscrollup(const Arg *);
 static void numlock(const Arg *);
 static void selpaste(const Arg *);
 static void zoom(const Arg *);
@@ -174,8 +176,8 @@ static void tputtab(int);
 static void tputc(Rune);
 static void treset(void);
 static void tresize(int, int);
-static void tscrollup(int, int);
-static void tscrolldown(int, int);
+static void tscrollup(int, int, int);
+static void tscrolldown(int, int, int);
 static void tsetattr(int *, int);
 static void tsetchar(Rune, Glyph *, int, int);
 static void tsetscroll(int, int);
@@ -218,6 +220,8 @@ char *opt_line  = NULL;
 char *opt_name  = NULL;
 char *opt_title = NULL;
 int oldbutton   = 3; /* button event on startup: 3 = release */
+char *cwd = NULL;
+char *plumber_cmd = plumber;
 
 static CSIEscape csiescseq;
 static STREscape strescseq;
@@ -455,10 +459,10 @@ tlinelen(int y)
 {
 	int i = term.col;
 
-	if (term.line[y][i - 1].mode & ATTR_WRAP)
+	if (TLINE(y)[i - 1].mode & ATTR_WRAP)
 		return i;
 
-	while (i > 0 && term.line[y][i - 1].u == ' ')
+	while (i > 0 && TLINE(y)[i - 1].u == ' ')
 		--i;
 
 	return i;
@@ -520,7 +524,7 @@ selsnap(int *x, int *y, int direction)
 		 * Snap around if the word wraps around at the end or
 		 * beginning of a line.
 		 */
-		prevgp = &term.line[*y][*x];
+		prevgp = &TLINE(*y)[*x];
 		prevdelim = ISDELIM(prevgp->u);
 		for (;;) {
 			newx = *x + direction;
@@ -535,14 +539,14 @@ selsnap(int *x, int *y, int direction)
 					yt = *y, xt = *x;
 				else
 					yt = newy, xt = newx;
-				if (!(term.line[yt][xt].mode & ATTR_WRAP))
+				if (!(TLINE(yt)[xt].mode & ATTR_WRAP))
 					break;
 			}
 
 			if (newx >= tlinelen(newy))
 				break;
 
-			gp = &term.line[newy][newx];
+			gp = &TLINE(newy)[newx];
 			delim = ISDELIM(gp->u);
 			if (!(gp->mode & ATTR_WDUMMY) && (delim != prevdelim
 					|| (delim && gp->u != prevgp->u)))
@@ -563,14 +567,14 @@ selsnap(int *x, int *y, int direction)
 		*x = (direction < 0) ? 0 : term.col - 1;
 		if (direction < 0) {
 			for (; *y > 0; *y += direction) {
-				if (!(term.line[*y-1][term.col-1].mode
+				if (!(TLINE(*y-1)[term.col-1].mode
 						& ATTR_WRAP)) {
 					break;
 				}
 			}
 		} else if (direction > 0) {
 			for (; *y < term.row-1; *y += direction) {
-				if (!(term.line[*y][term.col-1].mode
+				if (!(TLINE(*y)[term.col-1].mode
 						& ATTR_WRAP)) {
 					break;
 				}
@@ -601,13 +605,13 @@ getsel(void)
 		}
 
 		if (sel.type == SEL_RECTANGULAR) {
-			gp = &term.line[y][sel.nb.x];
+			gp = &TLINE(y)[sel.nb.x];
 			lastx = sel.ne.x;
 		} else {
-			gp = &term.line[y][sel.nb.y == y ? sel.nb.x : 0];
+			gp = &TLINE(y)[sel.nb.y == y ? sel.nb.x : 0];
 			lastx = (sel.ne.y == y) ? sel.ne.x : term.col-1;
 		}
-		last = &term.line[y][MIN(lastx, linelen-1)];
+		last = &TLINE(y)[MIN(lastx, linelen-1)];
 		while (last >= gp && last->u == ' ')
 			--last;
 
@@ -851,6 +855,9 @@ ttyread(void)
 	if (buflen > 0)
 		memmove(buf, ptr, buflen);
 
+	if (term.scr > 0 && term.scr < HISTSIZE-1)
+		term.scr++;
+
 	return ret;
 }
 
@@ -860,7 +867,10 @@ ttywrite(const char *s, size_t n)
 	fd_set wfd, rfd;
 	ssize_t r;
 	size_t lim = 256;
+	Arg arg = (Arg) { .i = term.scr };
 
+	kscrolldown(&arg);
+
 	/*
 	 * Remember that we are using a pty, which might be a modem line.
 	 * Writing too much will clog the line. That's why we are doing this
@@ -1062,13 +1072,53 @@ tswapscreen(void)
 }
 
 void
-tscrolldown(int orig, int n)
+kscrolldown(const Arg* a)
 {
+	int n = a->i;
+
+	if (n < 0)
+		n = term.row + n;
+
+	if (n > term.scr)
+		n = term.scr;
+
+	if (term.scr > 0) {
+		term.scr -= n;
+		selscroll(0, -n);
+		tfulldirt();
+	}
+}
+
+void
+kscrollup(const Arg* a)
+{
+	int n = a->i;
+
+	if (n < 0)
+		n = term.row + n;
+
+	if (term.scr <= HISTSIZE-n) {
+		term.scr += n;
+		selscroll(0, n);
+		tfulldirt();
+	}
+}
+
+void
+tscrolldown(int orig, int n, int copyhist)
+{
 	int i;
 	Line temp;
 
 	LIMIT(n, 0, term.bot-orig+1);
 
+	if (copyhist) {
+		term.histi = (term.histi - 1 + HISTSIZE) % HISTSIZE;
+		temp = term.hist[term.histi];
+		term.hist[term.histi] = term.line[term.bot];
+		term.line[term.bot] = temp;
+	}
+
 	tsetdirt(orig, term.bot-n);
 	tclearregion(0, term.bot-n+1, term.col-1, term.bot);
 
@@ -1082,13 +1132,20 @@ tscrolldown(int orig, int n)
 }
 
 void
-tscrollup(int orig, int n)
+tscrollup(int orig, int n, int copyhist)
 {
 	int i;
 	Line temp;
 
 	LIMIT(n, 0, term.bot-orig+1);
 
+	if (copyhist) {
+		term.histi = (term.histi + 1) % HISTSIZE;
+		temp = term.hist[term.histi];
+		term.hist[term.histi] = term.line[orig];
+		term.line[orig] = temp;
+	}
+
 	tclearregion(0, orig, term.col-1, orig+n-1);
 	tsetdirt(orig+n, term.bot);
 
@@ -1137,7 +1194,7 @@ tnewline(int first_col)
 	int y = term.c.y;
 
 	if (y == term.bot) {
-		tscrollup(term.top, 1);
+		tscrollup(term.top, 1, 1);
 	} else {
 		y++;
 	}
@@ -1302,14 +1359,14 @@ void
 tinsertblankline(int n)
 {
 	if (BETWEEN(term.c.y, term.top, term.bot))
-		tscrolldown(term.c.y, n);
+		tscrolldown(term.c.y, n, 0);
 }
 
 void
 tdeleteline(int n)
 {
 	if (BETWEEN(term.c.y, term.top, term.bot))
-		tscrollup(term.c.y, n);
+		tscrollup(term.c.y, n, 0);
 }
 
 int32_t
@@ -1743,11 +1800,11 @@ csihandle(void)
 		break;
 	case 'S': /* SU -- Scroll <n> line up */
 		DEFAULT(csiescseq.arg[0], 1);
-		tscrollup(term.top, csiescseq.arg[0]);
+		tscrollup(term.top, csiescseq.arg[0], 0);
 		break;
 	case 'T': /* SD -- Scroll <n> line down */
 		DEFAULT(csiescseq.arg[0], 1);
-		tscrolldown(term.top, csiescseq.arg[0]);
+		tscrolldown(term.top, csiescseq.arg[0], 0);
 		break;
 	case 'L': /* IL -- Insert <n> blank lines */
 		DEFAULT(csiescseq.arg[0], 1);
@@ -1865,6 +1922,9 @@ strhandle(void)
 	switch (strescseq.type) {
 	case ']': /* OSC -- Operating System Command */
 		switch (par) {
+		case 7:
+			if (narg > 1 && access(strescseq.args[1], X_OK) != -1)
+				cwd = strescseq.args[1];
 		case 0:
 		case 1:
 		case 2:
@@ -2297,7 +2357,7 @@ eschandle(uchar ascii)
 		return 0;
 	case 'D': /* IND -- Linefeed */
 		if (term.c.y == term.bot) {
-			tscrollup(term.top, 1);
+			tscrollup(term.top, 1, 1);
 		} else {
 			tmoveto(term.c.x, term.c.y+1);
 		}
@@ -2310,7 +2370,7 @@ eschandle(uchar ascii)
 		break;
 	case 'M': /* RI -- Reverse index */
 		if (term.c.y == term.top) {
-			tscrolldown(term.top, 1);
+			tscrolldown(term.top, 1, 1);
 		} else {
 			tmoveto(term.c.x, term.c.y-1);
 		}
@@ -2497,7 +2557,7 @@ check_control_code:
 void
 tresize(int col, int row)
 {
-	int i;
+	int i, j;
 	int minrow = MIN(row, term.row);
 	int mincol = MIN(col, term.col);
 	int *bp;
@@ -2536,6 +2596,14 @@ tresize(int col, int row)
 	term.alt  = xrealloc(term.alt,  row * sizeof(Line));
 	term.dirty = xrealloc(term.dirty, row * sizeof(*term.dirty));
 	term.tabs = xrealloc(term.tabs, col * sizeof(*term.tabs));
+
+	for (i = 0; i < HISTSIZE; i++) {
+		term.hist[i] = xrealloc(term.hist[i], col * sizeof(Glyph));
+		for (j = mincol; j < col; j++) {
+			term.hist[i][j] = term.c.attr;
+			term.hist[i][j].u = ' ';
+		}
+	}
 
 	/* resize each row to new width, zero-pad if needed */
 	for (i = 0; i < minrow; i++) {
