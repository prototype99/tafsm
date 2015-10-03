# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils multilib python-single-r1 git-2

DESCRIPTION="eXtensible Data Model and Format"
HOMEPAGE="http://xdmf.org/index.php/Main_Page"
#SRC_URI="https://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"
#EGIT_REPO_URI="git://xdmf.org/Xdmf.git"
EGIT_REPO_URI="git://public.kitware.com/Xdmf2.git"
#EGIT_REPO_URI="https://github.com/cjh1/Xdmf2"
#EGIT_BRANCH="vtk6"

SLOT="0"
LICENSE="VTK"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE="doc python test debug"

RDEPEND="
	sci-libs/hdf5:=
	dev-libs/libxml2:2
	python? ( ${PYTHON_DEPS} )
	"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	python? ( dev-lang/swig:0 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use doc XDMF_BUILD_DOCUMENTATION)
		$(cmake-utils_use_build test TESTING)
		$(cmake-utils_use python XDMF_WRAP_PYTHON)
#		$(cmake-utils_use java XDMF_WRAP_JAVA)
	)

	if use debug ; then
	filter-flags -O1
	filter-flags -O2
	filter-flags -O3
	append-flags -O0
	 elog "DEBUG";
	mycmakeargs+=(
	 -DCMAKE_CXX_FLAGS_DEBUG=${CXXFLAGS}
	 -DCMAKE_C_FLAGS_DEBUG=${CFLAGS}
	 -DCMAKE_CXX_FLAGS_RELWITHDEBINFO:STRING=${CXXFLAGS}
	 -DCMAKE_C_FLAGS_RELWITHDEBINFO:STRING=${CFLAGS}
	 )
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	insinto usr/share/cmake/Modules/
	elog ${S}
	newins ${S}_build/XdmfConfig.cmake xdmf2Config.cmake
}
