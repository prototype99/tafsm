# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )
inherit eutils python-single-r1 cmake-utils git-r3

MAIN_PV=$(ver_cut 1)
MAJOR_PV=$(ver_cut 1-2)
MY_P="${P}"

DESCRIPTION="ParaView is a powerful scientific data visualization application"
HOMEPAGE="http://www.paraview.org"
EGIT_REPO_URI="https://gitlab.kitware.com/paraview/paraview-superbuild.git"
EGIT_TAG="v${PV}"
SRC_URI="
http://www.paraview.org/files/v5.7/ParaView-v${PV}.tar.xz
https://www.paraview.org/files/dependencies/mesa-18.2.2.tar.xz
https://www.paraview.org/files/dependencies/nlohmannjson-3.6.1.tar.gz
https://www.paraview.org/files/dependencies/hdf5-1.10.5.tar.bz2
https://www.paraview.org/files/dependencies/lapack-3.4.2.tgz
https://www.paraview.org/files/dependencies/llvm-7.0.0.src.tar.xz
https://www.paraview.org/files/dependencies/Mako-1.0.7.tar.gz
https://www.paraview.org/files/dependencies/szip-2.1.1.tar.gz
https://www.paraview.org/files/dependencies/setuptools-23.0.0.tar.gz
https://www.paraview.org/files/dependencies/gperf-3.1.tar.gz
ospray? (
	https://www.paraview.org/files/data/OSPRayMaterials-0.2.tar.gz
	https://www.paraview.org/files/dependencies/ispc-v1.9.2-linux.tar.gz
	https://www.paraview.org/files/dependencies/ospray-1.8.4.tar.gz
	https://www.paraview.org/files/dependencies/embree-3.2.0.tar.gz
	https://www.paraview.org/files/dependencies/tbb2019_20190410oss_lin.tgz
	https://www.paraview.org/files/dependencies/oidn-0.8.1.src.tar.gz
)

"
#https://www.paraview.org/files/dependencies/scipy-1.2.2.tar.xz

RESTRICT="mirror"

LICENSE="paraview GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc mpi xdmf3 ospray python osmesa"
RESTRICT="test"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} ) "

RDEPEND="
	dev-libs/expat
	dev-libs/libxml2:2
	mpi? ( virtual/mpi[cxx,romio] )
	python? (
		${PYTHON_DEPS}
	)
	mpi? ( virtual/mpi[cxx,romio] )
	!sci-visualization/paraview
	"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	sys-libs/zlib
	=dev-util/ninja-1.9.0
	"

S="${WORKDIR}/${MY_P}"

#PATCHES=(
#	"${FILESDIR}/${P}_all_protected.patch"
#)
pkg_setup() {
	python-single-r1_pkg_setup
	PVLIBDIR=$(get_libdir)/${PN}-${MAJOR_PV}
	PARAVIEW_VERSION="${MAJOR_PV}"
	ParaView_BINARY_DIR="${WORKDIR}/paraview-${PV}_build"
}

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	CMAKE_BUILD_TYPE=Release
	local mycmakeargs=(
		-Dsuperbuild_download_location:PATH=${DISTDIR}
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DCMAKE_INSTALL_LIBDIR="${PVLIBDIR}"
		-DBUILD_SHARED_LIBS:BOOL=ON
		-DENABLE_paraview:BOOL=ON
		-DENABLE_cxx11:BOOL=ON
		-DUSE_SYSTEM_zlib:BOOL=ON
		-DUSE_SYSTEM_expat:BOOL=ON
		-DUSE_SYSTEM_png:BOOL=ON
		-DUSE_SYSTEM_libxml2:BOOL=ON
		-DENABLE_mpi:BOOL=$(usex mpi)
		-DUSE_SYSTEM_mpi:BOOL=$(usex mpi)
		-DENABLE_xdmf3:BOOL=$(usex xdmf3)
		-DENABLE_python3:BOOL=$(usex python)
		-DENABLE_numpy:BOOL=$(usex python)
		#-DENABLE_scipy:BOOL=$(usex python)
		-DUSE_SYSTEM_python3:BOOL=$(usex python)
		-DUSE_SYSTEM_numpy:BOOL=$(usex python)
		-DENABLE_lapack:BOOL=ON
		-DENABLE_ispc:BOOL=$(usex ospray)
		-DENABLE_ospray:BOOL=$(usex ospray)
		-DENABLE_tbb:BOOL=$(usex ospray)
		-DENABLE_embree:BOOL=$(usex ospray)
		-DENABLE_ospraymaterials:BOOL=$(usex ospray)
		-DENABLE_osmesa:BOOL=$(usex osmesa)
		-Dmesa_USE_SWR:BOOL=$(usex osmesa)
		-DENABLE_qt5:BOOL=$(usex osmesa OFF ON)

		-DSUPPRESS_embree_OUTPUT:BOOL=ON
		-DSUPPRESS_hdf5_OUTPUT:BOOL=ON
		-DSUPPRESS_ispc_OUTPUT:BOOL=ON
		-DSUPPRESS_lapack_OUTPUT:BOOL=ON
		-DSUPPRESS_llvm_OUTPUT:BOOL=ON
		-DSUPPRESS_nlohmannjson_OUTPUT:BOOL=ON
		-DSUPPRESS_openimagedenoise_OUTPUT:BOOL=ON
		-DSUPPRESS_osmesa_OUTPUT:BOOL=ON
		-DSUPPRESS_ospray_OUTPUT:BOOL=ON
		-DSUPPRESS_ospraymaterials_OUTPUT:BOOL=ON
		-DSUPPRESS_paraview_OUTPUT:BOOL=ON
		-DSUPPRESS_pythonmako_OUTPUT:BOOL=ON
		-DSUPPRESS_pythonsetuptools_OUTPUT:BOOL=ON
		-DSUPPRESS_szip_OUTPUT:BOOL=ON
		-DSUPPRESS_tbb_OUTPUT:BOOL=ON

	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}
src_install() {
	cmake-utils_src_install
}

