# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
#inherit distutils versionator git-r3
inherit distutils versionator

DESCRIPTION=""
HOMEPAGE="http://www.openvdb.org/"
#MY_PV=$(replace_all_version_separators  '_')
#MY_P="${PN}_${MY_PV}"
SRC_URI="https://github.com/dreamworksanimation/openvdb/archive/v${PV}.tar.gz"
#EGIT_REPO_URI="https://github.com/dreamworksanimation/openvdb"

LICENSE="Mozilla Public License Version 2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python doc"
RESTRICT_PYTHON_ABIS="2.[67]"
DEPEND="
	dev-libs/boost
	dev-cpp/tbb
	media-libs/openexr
	>=media-libs/glfw-3.1.1
	dev-libs/jemalloc
	dev-libs/log4cplus
	dev-util/cppunit
	media-libs/ilmbase
	doc? ( dev-python/epydoc
		  app-doc/doxygen )
	python? ( dev-libs/boost[python] dev-python/numpy )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${P}/${PN}"

src_configure(){
	epatch "${FILESDIR}/gentoo-install.patch"
#sed -i "788s#/python/lib/python\$(PYTHON_VERSION);#/lib/python\$(PYTHON_VERSION)/site-packages;#" ${S}/Makefile
}
mymakeargs=""
src_compile() {
	mymakeargs="
		DESTDIR=${D}usr
		BOOST_INCL_DIR=/usr/include
		BOOST_LIB_DIR=/usr/$(get_libdir)
		EXR_INCL_DIR=/usr/include/OpenEXR
		EXR_LIB_DIR=/usr/$(get_libdir)
		EXR_LIB=-lIlmImf
		HALF_INCL_DIR=/usr/include/OpenEXR
		HALF_LIB_DIR=/usr/$(get_libdir)
		HALF_LIB=-lHalf
		TBB_INCL_DIR=/usr/include/tbb/
		TBB_LIB_DIR=/usr/$(get_libdir)
		TBB_LIB=-ltbb
		CPPUNIT_INCL_DIR=/usr/include/cppunit/
		CPPUNIT_LIB_DIR=/usr/$(get_libdir)
		CPPUNIT_LIB=-lcppunit
		GLFW_INCL_DIR=/usr/include/GL
		GLFW_LIB_DIR=/usr/$(get_libdir)
		GLFW_LIB=-lglfw
		LOG4CPLUS_INCL_DIR=/usr/include/log4cplus
		LOG4CPLUS_LIB_DIR=/usr/$(get_libdir)
		LOG4CPLUS_LIB=-llog4cplus
	"
#CONCURRENT_MALLOC_LIB_DIR
	mymakeargs="${mymakeargs} CONCURRENT_MALLOC_LIB="

	if use python; then
		mymakeargs="${mymakeargs} BOOST_PYTHON_LIB_DIR=/usr/$(get_libdir)"
		mymakeargs="${mymakeargs} BOOST_PYTHON_LIB=-lboost_python-$(python_get_version)-mt"
		mymakeargs="${mymakeargs} NUMPY_INCL_DIR=/usr/lib64/python$(python_get_version)/site-packages/numpy/core/include/numpy"
		mymakeargs="${mymakeargs} PYTHON_WRAP_ALL_GRID_TYPES=yes"
		mymakeargs="${mymakeargs} PYTHON_VERSION=$(python_get_version)"
		mymakeargs="${mymakeargs} PYTHON_INCL_DIR=$(python_get_includedir)"
		mymakeargs="${mymakeargs} PYCONFIG_INCL_DIR=$(python_get_includedir)"
		mymakeargs="${mymakeargs} PYTHON_LIB_DIR=$(python_get_libdir)"
		mymakeargs="${mymakeargs} PYTHON_LIB=$(python_get_library -l)"
	else
		mymakeargs="${mymakeargs} PYTHON_VERSION= "
		:
	fi
	if use doc; then
		mymakeargs="${mymakeargs} EPYDOC=epydoc"
		mymakeargs="${mymakeargs} DOXYGEN=doxygen"
	else
		mymakeargs="${mymakeargs} EPYDOC="
		mymakeargs="${mymakeargs} DOXYGEN="
	fi
	elog $mymakeargs
	emake $mymakeargs || die "emake failed"
}
src_install(){
	emake ${mymakeargs} install || die "emake install failed"
#	doexe vdb_print
#	doexe vdb_render
#	doexe vdb_view
#	dolib.so libopenvdb.so
#	dolib.so libopenvdb.so.3.0
#	dolib.so libopenvdb.so.3.0.0
#	if use python; then
#		:
#	fi
#	if use doc; then
#		:
#	fi
}
distutils_pkg_postinst(){
	:
}
