# $FreeBSD$

# PORTNAME block
PORTNAME=
DISTVERSIONPREFIX=	v
DISTVERSION=	0.4.2
CATEGORIES=

# PATCHFILES block

# MAINTAINER block
MAINTAINER=	0mp@FreeBSD.org
COMMENT=

# LICENSE block
LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

# Generic BROKEN/IGNORE/DEPRECATED messages

# The dependencies block

BUILD_DEPENDS=
RUN_DEPENDS=	libcpr.so>0:www/cpr \
		libcivetweb.so>0:www/civetweb
TEST_DEPENDS=	${RUN_DEPENDS} \
		googletest>0:devel/googletest

# Flavors

# USES and USE_x
USES=
USE_GITHUB=	yes
GH_ACCOUNT=
GH_PROJECT=

# Standard bsd.port.mk variables

# Options and helpers
OPTIONS_DEFINE=	CPP DOCS
OPTIONS_DEFAULT=CPP DOCS
OPTIONS_SUB=	yes

CPP_DESC=	Build libraries with C++ classes
CPP_INSTALL_TARGET+=	install-headers
CPP_MAKE_ARGS+=	WITH_CPP="1"

# The rest of the variables

# The targets

.include <bsd.port.mk>
