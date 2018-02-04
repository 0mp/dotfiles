# Created by: 0mp@FreeBSD.org
# $FreeBSD$

PORTNAME=	sterm-0mp
DISTVERSION=	g20171226
PORTEPOCH=	1
CATEGORIES=	x11

MAINTAINER=	0mp@FreeBSD.org
COMMENT=	Simple X terminal

LICENSE=	MITX
LICENSE_NAME=	MIT/X Consortium License
LICENSE_FILE=	${WRKSRC}/LICENSE
LICENSE_PERMS=	dist-mirror dist-sell pkg-mirror pkg-sell auto-accept

LIB_DEPENDS=	libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2

USES=		pkgconfig ncurses:port
USE_XORG=	x11 xext xft

USE_GITHUB=	yes
GH_ACCOUNT=	0mp
GH_PROJECT=	st
GH_TAGNAME=	1f24bde

PLIST_FILES=	bin/st man/man1/st.1.gz

PORTDOCS=	README

OPTIONS_DEFINE=	DOCS SCROLLBACK PLUMBER
OPTIONS_DEFAULT=	SCROLLBACK PLUMBER

SCROLLBACK_EXTRA_PATCHES=	${PATCHDIR}/extra-patch-scrollback
PLUMBER_EXTRA_PATCHES=	${PATCHDIR}/extra-patch-plumber ${PATCHDIR}/extra-patch-plumber-config.def.h

post-patch:
.if defined(ST_CONF)
	@${ECHO_MSG} "creating config.h from ${ST_CONF}"
	@${CP} ${ST_CONF} ${WRKSRC}/config.h
.endif
	@${REINPLACE_CMD} -e 's|^VERSION = .*|VERSION = ${PORTVERSION}|' \
		-e 's|^PREFIX = .*|PREFIX = ${PREFIX}|' \
		-e 's|^LOCALBASE = .*|LOCALBASE = ${LOCALBASE}|' \
		-e "s|^MANPREFIX = .*|MANPREFIX = ${MANPREFIX}/man|" \
		-e "s|^X11INC = .*|X11INC = ${LOCALBASE}/include|" \
		-e "s|^X11LIB = .*|X11LIB = ${LOCALBASE}/lib|" \
		${WRKSRC}/config.mk

post-install:
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/st

post-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
.for doc in ${PORTDOCS}
	${INSTALL_DATA} ${WRKSRC}/${doc} ${STAGEDIR}${DOCSDIR}
.endfor

.include <bsd.port.mk>
