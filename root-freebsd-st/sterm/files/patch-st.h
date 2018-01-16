--- st.h.orig	2018-01-16 00:02:17 UTC
+++ st.h
@@ -2,6 +2,7 @@
 
 /* Arbitrary sizes */
 #define UTF_SIZ       4
+#define HISTSIZE      2000
 
 /* macros */
 #define MIN(a, b)		((a) < (b) ? (a) : (b))
@@ -20,6 +21,9 @@
 #define TRUECOLOR(r,g,b)	(1 << 24 | (r) << 16 | (g) << 8 | (b))
 #define IS_TRUECOL(x)		(1 << 24 & (x))
 
+#define TLINE(y)		((y) < term.scr ? term.hist[((y) + term.histi - term.scr \
+				+ HISTSIZE + 1) % HISTSIZE] : term.line[(y) - term.scr])
+
 enum glyph_attribute {
 	ATTR_NULL       = 0,
 	ATTR_BOLD       = 1 << 0,
@@ -114,6 +118,9 @@ typedef struct {
 	int col;      /* nb col */
 	Line *line;   /* screen */
 	Line *alt;    /* alternate screen */
+	Line hist[HISTSIZE]; /* history buffer */
+	int histi;    /* history index */
+	int scr;      /* scroll back */
 	int *dirty;  /* dirtyness of lines */
 	GlyphFontSpec *specbuf; /* font spec buffer used for rendering */
 	TCursor c;    /* cursor */
