# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit distutils eutils flag-o-matic toolchain-funcs versionator cmake-utils

DESCRIPTION="Anisotropic Tetrahedral Remesher/Moving Mesh Generation "
HOMEPAGE="http://www.math.u-bordeaux1.fr/~cdobrzyn/logiciels/mmg3d.php"
#SRC_URI="http://www.math.u-bordeaux1.fr/~cdobrzyn/logiciels/download.php?file=mmg3d4.0.tgz"
SRC_URI="http://www.ivie4.tafsm.org/~ktaki/mmg3d4.0.tgz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64"
IUSE="static"

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}4/build"
CMAKE_IN_SOURCE_BUILD='True'

src_configure() {
	mycmakeargs=(
		-DUSE_SCOTCH=OFF 
	)
	if use static; then
		mycmakeargs+=( -DCOMPIL_STATIC_LIBRARY=ON )
	else
		mycmakeargs+=( -DCOMPIL_SHARED_LIBRARY=ON )
	fi
	cmake-utils_src_configure
}
src_compile(){
	emake ${PN}${PV} ${PN}lib${PV}
}
src_install(){
	dobin ${PN}${PV} 
	dolib.so lib${PN}lib${PV}.so
}
