PKGNAMESUFFIX=	-0mp
PORTREVISION=	4

CONFLICTS_INSTALL=	dwm

EXTRA_PATCHES=	${.CURDIR}/files/patch-0mp-*.diff
MASTERDIR=	${PORTSDIR}/x11-wm/dwm

DWM_CONF=	${.CURDIR}/files/config.h

.include "${MASTERDIR}/Makefile"

RUN_DEPENDS+=	find-cursor:x11/find-cursor
