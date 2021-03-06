# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit versionator python-single-r1

DESCRIPTION="The package gathers various tools and libraries for CGNS end-users
and Python application developpers. The main object of pyCGNS is to provide the
application developpers with a Python interface to CGNS/SIDS, the data model.
The MAP and PAT modules are dedicated to this goal: map the CGNS/SIDS data model
the CGNS/Python implementation. The WRA module contains wrapper on CGNS/MLL and
a MLL-like set of functions that uses the CGNS/Python mapping as implementation.
The NAV module supports the CGNS.NAV graphical browser, with nice features about
tree exploration, copy/paste and even global node changes. Then, the VAL module
is a parser engine for CGNS/Python tree compliance checking. The CGNS.VAL tool
can analyze your CGNS/HDF5 file and returns you a list of diagnostics."
HOMEPAGE="http://pycgns.sourceforge.net"

#MY_P="${PN}-v$(get_version_component_range 1-2).351"
MY_P="${PN}-v${PV}"
S="${WORKDIR}"/${MY_P}

SRC_URI="http://sourceforge.net/projects/pycgns/files/pyCGNS/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-lang/python-2.4
	>=dev-python/numpy-1.1
	>=dev-python/cython-0.16
	>=dev-qt/qtcore-4.7
	>=sci-libs/hdf5-1.8.5
	>=sci-libs/CHLone-0.45
	dev-python/pyside
"

src_configure(){
	file="pyCGNSconfig_user.py"
	echo "HDF5_PATH_INCLUDES  = ['/usr/include']" >> $file
	echo "HDF5_PATH_LIBRARIES = ['/usr/$(get_libdir)']" >> $file
#echo "HDF5_EXTRA_ARGS     = ['-DMYFLAG']" >> $file
	echo "HDF5_EXTRA_ARGS     = ['']" >> $file
	echo "CHLONE_PATH_INCLUDES=['/usr/include']" >> $file
	echo "CHLONE_PATH_LIBRARIES=['/usr/$(get_libdir)']" >> $file
	echo "NUMPY_PATH_LIBRARIES=['/usr/$(get_libdir)']" >> $file
	echo "MLL_PATH_LIBRARIES  =['/usr/$(get_libdir)']" >> $file
	echo "MLL_PATH_INCLUDES   =['/usr/include']" >> $file
	#cmake-utils_src_configure
}

src_compile(){
	##cmake-utils_src_compile
	"${PYTHON}" setup.py build  || die
}
src_install() {
	${PYTHON} setup.py install  --prefix=${D}usr || die
	#cmake-utils_src_install
}
