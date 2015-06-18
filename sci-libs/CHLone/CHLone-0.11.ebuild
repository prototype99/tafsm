# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit scons-utils distutils multilib


DESCRIPTION="CHLone is a CGNS/SIDS compliant mapping of SIDS-to-HDF5"
HOMEPAGE="http://chlone.sourceforge.net/"
SRC_URI="http://sourceforge.net/projects/chlone/files/CHLone/CHLone-v0.11.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="hdf5"

DEPEND=""
RDEPEND="${DEPEND}
	dev-util/scons
	hdf5? ( >=sci-libs/hdf5-1.8 )
"
MY_P="CHLone-v0.11"
S="${WORKDIR}/${MY_P}"
src_configure(){
	echo "CHLONE_INSTALL_INCLUDES='${D}usr/include'"  >> SConstructSetUp.py
	echo "CHLONE_INSTALL_DOCS='${D}usr/share'" >> SConstructSetUp.py
	echo "CHLONE_INSTALL_LIBRARIES='${D}usr/$(get_libdir)'" >> SConstructSetUp.py
	echo "CHLONE_INSTALL_PYMODULE='${D}/usr/$(get_libdir)/python$(python_get_version)/site-packages'" >> SConstructSetUp.py
	echo "HDF5_INCLUDES_PATHS='/usr/include'" >> SConstructSetUp.py
	echo "HDF5_LIBRARIES_PATHS='/usr/$(get_libdir)/'" >> SConstructSetUp.py
#	echo "HDF5_LIBRARIES='/usr/lib64/'" >> SConstructSetUp.py
}

src_compile(){
	escons
}
src_install(){
	escons  install
}

src_test(){
	escons  tests
}
