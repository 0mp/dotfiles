# Created by: 0mp@FreeBSD.org
# $FreeBSD$

PORTNAME=	sterm-0mp
DISTVERSION=	g20171226
PORTREVISION=	1
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

USES=		ncurses:port
USE_XORG=	x11 xext xft

USE_GITHUB=	yes
GH_ACCOUNT=	0mp
GH_PROJECT=	st
GH_TAGNAME=	1f24bde

# charcoal_PORTDOCS=	README

OPTIONS_DEFINE=	DOCS SCROLLBACK PLUMBER FONT TERMNAME SHINE
OPTIONS_DEFAULT=	SCROLLBACK PLUMBER FONT TERMNAME

SCROLLBACK_EXTRA_PATCHES=	${PATCHDIR}/extra-patch-scrollback
PLUMBER_EXTRA_PATCHES=	${PATCHDIR}/extra-patch-plumber ${PATCHDIR}/extra-patch-plumber-config.def.h
FONT_EXTRA_PATCHES=	${PATCHDIR}/extra-patch-font
TERMNAME_EXTRA_PATCHES=	${PATCHDIR}/extra-patch-termname

FLAVORS=	charcoal shine
FLAVOR?=	${FLAVORS:[1]}
charcoal_PKGNAMESUFFIX=	-charcoal
charcoal_PLIST=	bin/st-charcoal \
			man/man1/st.1.gz
shine_PKGNAMESUFFIX=	-shine
shine_PLIST=		bin/st-shine

.if ${FLAVOR:U} == charcoal
PLIST_FILES+=	${charcoal_PLIST}
.else
OPTIONS_DEFAULT+=	SHINE
SHINE_EXTRA_PATCHES=	${PATCHDIR}/extra-patch-shine
PLIST_FILES+=	${shine_PLIST}
.endif

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
	@${MV} ${STAGEDIR}${PREFIX}/bin/st ${STAGEDIR}${PREFIX}/bin/st${PKGNAMESUFFIX}
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/st${PKGNAMESUFFIX}

post-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
.for doc in ${PORTDOCS}
	${INSTALL_DATA} ${WRKSRC}/${doc} ${STAGEDIR}${DOCSDIR}
.endfor

.include <bsd.port.mk>
