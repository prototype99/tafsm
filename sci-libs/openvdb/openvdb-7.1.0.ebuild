# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python3_6 python3_7 )

inherit eutils python-single-r1 cmake-utils

DESCRIPTION=""
HOMEPAGE="http://www.openvdb.org/"
#MY_PV=$(ver_rs 1- '_')
#MY_P="${PN}_${MY_PV}"
SRC_URI="https://github.com/AcademySoftwareFoundation/openvdb/archive/v${PV}.tar.gz"

LICENSE="Mozilla Public License Version 2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python doc"
#RESTRICT_PYTHON_ABIS="2.[67]"
DEPEND="
	dev-libs/boost
	dev-cpp/tbb
	media-libs/ilmbase
	media-libs/openexr
	dev-libs/c-blosc
	>=media-libs/glfw-3.1.1
	dev-libs/jemalloc
	dev-libs/log4cplus
	dev-util/cppunit
	doc? ( dev-python/epydoc app-doc/doxygen )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-python/numpy[${PYTHON_USEDEP}]
		')
	)

"
RDEPEND="${DEPEND}"

REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )"

S="${WORKDIR}"/"${PN}-${PV}"

#src_configure(){
#	#epatch "${FILESDIR}/gentoo-install.patch"
##sed -i "788s#/python/lib/python\$(PYTHON_VERSION);#/lib/python\$(PYTHON_VERSION)/site-packages;#" ${S}/Makefile
#}
src_configure() {
	local mycmakeargs=(
		DESTDIR="${D}usr"
		DESTDIR_LIB_DIR="${D}/usr/$(get_libdir)"
		BOOST_INCL_DIR="/usr/include"
		BOOST_LIB_DIR="/usr/$(get_libdir)"
		EXR_INCL_DIR="/usr/include/OpenEXR"
		EXR_LIB_DIR="/usr/$(get_libdir)"
		EXR_LIB="-lIlmImf"
		HALF_INCL_DIR="/usr/include/OpenEXR"
		HALF_LIB_DIR="/usr/$(get_libdir)"
		HALF_LIB="-lHalf"
		TBB_INCL_DIR="/usr/include/tbb/"
		TBB_LIB_DIR="/usr/$(get_libdir)"
		TBB_LIB="-ltbb"
		CPPUNIT_INCL_DIR="/usr/include/cppunit/"
		CPPUNIT_LIB_DIR="/usr/$(get_libdir)"
		CPPUNIT_LIB="-lcppunit"
		GLFW_INCL_DIR="/usr/include/GL"
		GLFW_LIB_DIR="/usr/$(get_libdir)"
		GLFW_LIB="-lglfw"
		LOG4CPLUS_INCL_DIR="/usr/include/log4cplus"
		LOG4CPLUS_LIB_DIR="/usr/$(get_libdir)"
		LOG4CPLUS_LIB="-llog4cplus"
	)
#CONCURRENT_MALLOC_LIB_DIR
		mycmakeargs+=( CONCURRENT_MALLOC_LIB= )
		if use python; then
			mycmakeargs+=(
			PYTHON_VERSION="${EPYTHON#python}"
			PYTHON_INCL_DIR="$(python_get_includedir)
			PYTHON_LIB_DIR="$(python_get_library_path)
			BOOST_PYTHON_LIB_DIR="/usr/$(get_libdir)"
			BOOST_PYTHON_LIB="-lboost_python-${EPYTHON#python}-mt"
			NUMPY_INCL_DIR="/usr/$(get_libdir)/${EPYTHON}/site-packages/numpy/core/include/numpy"
			PYTHON_WRAP_ALL_GRID_TYPES="yes"
			)
	 		elog "${EPYTHON#python}"
	 		elog "$(python_get_includedir)"
	 		elog "$(python_get_library_path)"
	 		elog "/usr/$(get_libdir)/${EPYTHON}/site-packages/numpy/core/include/numpy"
			else
				mycmakeargs+=(PYTHON_VERSION= )
		fi
		if use doc; then
			mycmakeargs+=(EPYDOC="epydoc")
			mycmakeargs+=(DOXYGEN="doxygen")
		else
			mycmakeargs+=(EPYDOC=)
			mycmakeargs+=(DOXYGEN=)
		fi
	cmake-utils_src_configure
}
#src_compile() {
#	building(){
#		build_args
#		emake $mycmakeargs || die "emake failed"
#	}
#	#python_foreach_impl building
#}

#src_install(){
#
#	installation() {
#		build_args
#		emake ${mycmakeargs} install || die "emake install failed"
#	}
#	#python_foreach_impl installation
#
#	#	doexe vdb_print
#	#	doexe vdb_render
#	#	doexe vdb_view
#	#	dolib.so libopenvdb.so
#	#	dolib.so libopenvdb.so.3.0
#	#	dolib.so libopenvdb.so.3.0.0
#	#	if use python; then
#	#		:
#	#	fi
#	#	if use doc; then
#	#		:
#	#	fi
#}
#distutils_pkg_postinst(){
#	:
#}
