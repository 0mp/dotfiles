# Created by: 0mp@FreeBSD.org
# $FreeBSD$

PORTNAME=	sterm-0mp
DISTVERSION=	g20171226
PORTREVISION=	3
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

BINARY_ALIAS+= tic=true
USES=		pkgconfig
USE_XORG=	x11 xext xft

CONFLICTS_INSTALL=	x11/sterm

USE_GITHUB=	yes
GH_ACCOUNT=	0mp
GH_PROJECT=	st
GH_TAGNAME=	1f24bde

OPTIONS_DEFINE=		SCROLLBACK PLUMBER FONT TERMNAME SHINE DOCS
OPTIONS_DEFAULT=	SCROLLBACK PLUMBER FONT TERMNAME

SCROLLBACK_EXTRA_PATCHES=	${PATCHDIR}/extra-patch-scrollback
PLUMBER_EXTRA_PATCHES=		${PATCHDIR}/extra-patch-plumber \
				${PATCHDIR}/extra-patch-plumber-config.def.h
FONT_EXTRA_PATCHES=		${PATCHDIR}/extra-patch-font
TERMNAME_EXTRA_PATCHES=		${PATCHDIR}/extra-patch-termname

FLAVORS=		charcoal shine data
FLAVOR?=		${FLAVORS:[1]}

charcoal_PKGNAMESUFFIX=	-charcoal
charcoal_PLIST=		bin/st-charcoal
.if ${FLAVOR:U} == charcoal
PLIST_FILES+=		${charcoal_PLIST}
.endif

shine_PKGNAMESUFFIX=	-shine
shine_PLIST=		bin/st-shine
.if ${FLAVOR:U} == shine
OPTIONS_DEFAULT+=	SHINE
SHINE_EXTRA_PATCHES=	${PATCHDIR}/extra-patch-shine
PLIST_FILES+=		${shine_PLIST}
.endif

data_PKGNAMESUFFIX=	-data
data_PLIST=		man/man1/st.1.gz
data_PORTDOCS=		README
.if ${FLAVOR:U} == data
PLIST_FILES+=		${data_PLIST}
PORTDOCS+=		${data_PORTDOCS}
.endif

CFLAGS+=		-I/usr/local/include/freetype2

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

.if ${FLAVOR:U} == data
do-install-DOCS-on:
	cd ${WRKSRC} && ${COPYTREE_SHARE} "${PORTDOCS}" ${STAGEDIR}${DOCSDIR}
.endif

.include <bsd.port.mk>
