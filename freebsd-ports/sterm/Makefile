PKGNAMESUFFIX=	-0mp
PORTREVISION=	1

CONFLICTS_INSTALL=	sterm

MASTERDIR=	${PORTSDIR}/x11/sterm

SUB_FILES+=	../../../../../../../../../../../../..${.CURDIR}/files/config.h

ST_CONF=	${.CURDIR}/files/config.h

OPTIONS_DEFAULT+=	SCROLLBACK

.include "${MASTERDIR}/Makefile"

.if defined(LOW_RESOLUTION)
SUB_LIST=		FONT="Inconsolata:pixelsize=12"
RUN_DEPENDS=		inconsolata-ttf>=0:x11-fonts/inconsolata-ttf
.else
SUB_LIST_OFF=		FONT="iosevka-term:pixelsize=19"
RUN_DEPENDS_OFF=	iosevka>=0:x11-fonts/iosevka
.endif
