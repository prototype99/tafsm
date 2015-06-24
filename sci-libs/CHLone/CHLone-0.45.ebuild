# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit scons-utils distutils 


DESCRIPTION="CHLone is a CGNS/SIDS compliant mapping of SIDS-to-HDF5"
HOMEPAGE="http://chlone.sourceforge.net/"
MY_P="CHLone-v${PV}"
SRC_URI="http://sourceforge.net/projects/chlone/files/CHLone/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="hdf5"

DEPEND=""
RDEPEND="${DEPEND}
	dev-util/scons
	hdf5? ( >=sci-libs/hdf5-1.8 )
"
S="${WORKDIR}/${MY_P}"
src_configure(){
	echo "CHLONE_INSTALL_INCLUDES='/usr/include'"  >> SConstructSetUp.py
	echo "CHLONE_INSTALL_DOCS='/usr/share'" >> SConstructSetUp.py
	echo "CHLONE_INSTALL_LIBRARIES='/usr/$(get_libdir)'" >> SConstructSetUp.py
	echo "CHLONE_INSTALL_PYMODULE='/usr/$(get_libdir)/python$(python_get_version)/site-packages'" >> SConstructSetUp.py
	echo "HDF5_INCLUDES_PATHS=['/usr/include']" >> SConstructSetUp.py
	echo "HDF5_LIBRARIES_PATHS=['/usr/$(get_libdir)/']" >> SConstructSetUp.py
	echo "HDF5_LIBRARIES=['hdf5']" >> SConstructSetUp.py
}

src_compile(){
	escons  INSTALL_ROOT="${D}"
}
src_install(){
	#escons  install INSTALL_ROOT="${D}"
	cd .scons.linux2.tmp/build
	insinto "${EPREFIX}/usr/include/CHLone"
	find "src/include/CHLone" -type f -name "*.h" | while read f ; do
		doins $f 
	done
	dolib src/libCHLone.so
	insinto $(python_get_sitedir)/CHLone
	doins pyx/CHLone.so
}

src_test(){
	escons  tests
}
distutils_pkg_postinst(){
	:
}
distutils_pkg_postrm(){
	:
}
