# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
#inherit distutils eutils flag-o-matic toolchain-funcs versionator qt4 cmake-utils
inherit distutils flag-o-matic toolchain-funcs versionator cmake-utils


DESCRIPTION="Gmsh is a 3D finite element grid generator with a build-in CAD
engine and post-processor. Its design goal is to provide a fast, light and
user-friendly meshing tool with parametric input and advanced visualization
capabilities. Gmsh is built around four modules: geometry, mesh, solver and
post-processing. The specification of any input to these modules is done either
interactively using the graphical user interface or in ASCII text files using
Gmsh's own scripting language."
HOMEPAGE="http://geuz.org/gmsh/"
SRC_URI="http://geuz.org/gmsh/src/${P}-source.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="gui netgen tetgen occ petsc"

DEPEND="
		dev-util/cmake
	gui? ( x11-libs/fltk[opengl] )
	netgen? ( sci-libs/netgen )
	tetgen? ( sci-libs/tetgen )
	occ?  ( sci-libs/opencascade )
	petsc?  ( >=sci-libs/petsc-3.4.4 >=sci-libs/slepc-3.4.4 )
"
	#petsc?  ( <sci-libs/petsc-3.3 <sci-libs/slepc-3.3 )
RDEPEND="${DEPEND}"

S="${WORKDIR}"/gmsh"-${PV}-source"

#PETSC_ARCH="linux-gnu"
#PYTHON_MODNAME=""

src_configure() {
	mycmakeargs=(
		ENABLE_METIS:BOOl=ON
		ENABLE_TAUCS:BOOl=OFF
		ENABLE_MM3:BOOL=ON
		CMAKE_PREFIX_PATH:PATH=${EPREFIX}usr
		CMAKE_INSTALL_PREFIX:PATH=${EPREFIX}usr
	)
	if use petsc; then
		mycmakeargs+=( ENABLE_PETS:BOOL=ON  )
		local v=$(best_version sci-libs/petsc)
		v=${v#sci-libs/}
		v=$(get_version_component_range 1-4 $v)
		export PETSC_ARCH=""
		export PETSC_DIR="${EPREFIX}/usr/share/${v}"
		v=$(best_version sci-libs/slepc)
		v=${v#sci-libs/}
		export SLEPC_DIR="${EPREFIX}/usr/share/${v}"

#export PETSC_ARCH
		elog PETSC_DIR=${PETSC_DIR}
		elog SLEPC_DIR=${SLEPC_DIR}

	else
		mycmakeargs+=( ENABLE_PETS:BOOL=OFF )
	fi
	if use gui; then
		mycmakeargs+=( ENABLE_FLTK:BOOL=ON )
	else
		mycmakeargs+=( ENABLE_FLTK:BOOL=OFF )
	fi
	if use occ; then
		mycmakeargs+=( ENABLE_OCC:BOOL=ON )
	else
		mycmakeargs+=( ENABLE_OCC:BOOL=OFF )
	fi
	if use netgen; then
		mycmakeargs+=( ENABLE_NETGEN:BOOL=ON )
	else
		mycmakeargs+=( ENABLE_NETGEN:BOOL=OFF )
	fi
	if use tetgen; then
		mycmakeargs+=( ENABLE_TETGEN:BOOL=ON )
	else
		mycmakeargs+=( ENABLE_TETGEN:BOOL=OFF )
	fi
	cmake-utils_src_configure
	unset PYTHON_MODNAME
}

#src_compile(){
#	elog PETSC_DIR=${PETSC_DIR}
#	elog SLEPC_DIR=${SLEPC_DIR}
#	cd "${WORKDIR}"/gmsh"-${PV}_build"
#	emake
#}
#
#src_install() {
#	cmake-utils_src_install
#}

