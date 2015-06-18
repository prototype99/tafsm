# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/paraview/paraview-3.6.2.ebuild,v 1.4 2010/01/30 18:01:05 markusle Exp $

EAPI="4"

#inherit distutils eutils flag-o-matic toolchain-funcs versionator python qt4 cmake-utils
inherit flag-o-matic eutils toolchain-funcs versionator python qt4-r2 cmake-utils

MAIN_PV=$(get_major_version)
MAJOR_PV=$(get_version_component_range 1-2)

DESCRIPTION="ParaView is a powerful scientific data visualization application"
HOMEPAGE="http://www.paraview.org"
SRC_URI="http://www.paraview.org/files/v3.98/ParaView-3.98.1-source.tar.gz"

LICENSE="paraview GPL-2"
KEYWORDS="~x86 amd64"
SLOT="0"
#USE="gl2ps"
IUSE="mpi +python doc examples +gui plugins boost streaming cg overview mysql
postgres odbc +gl2ps osmesa"
RDEPEND="mpi? ( || (
				sys-cluster/openmpi
				sys-cluster/mpich2[cxx] ) )
	python? ( dev-lang/python )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-base )
	osmesa? ( >=media-libs/mesa-7.11.2 )
	odbc? ( dev-db/unixODBC )
	gl2ps? ( x11-libs/gl2ps )
	dev-libs/libxml2
	media-libs/libpng
	virtual/jpeg
	media-libs/tiff
	media-video/ffmpeg
	>=dev-libs/protobuf-2.3.0-r1
	dev-libs/expat
	sys-libs/zlib
	media-libs/freetype
	>=app-admin/eselect-opengl-1.0.6-r1
	virtual/opengl
	sci-libs/netcdf
	x11-libs/libXmu"

DEPEND="${RDEPEND}
		boost? (  >=dev-libs/boost-1.40.0 )
		doc? ( app-doc/doxygen )
		>=dev-util/cmake-2.8.8"

PVLIBDIR="$(get_libdir)/${PN}-${MAJOR_PV}"
S="${WORKDIR}"/ParaView"-${MAJOR_PV}.1-source"
LIBRARY_PATH="${WORKDIR}/paraview-3.98.1_build/lib"
PYTHON_MODNAME="paraview"

#pkg_setup() {
#	if (use overview) && (! use gui); then
#		die "the overview plugin requires the USE='gui'"
#	fi
#}

# src_prepare() {
# epatch "${FILESDIR}"/bundlefixfix.patch
# ###	epatch "${FILESDIR}"/${P}-qt.patch
# ###	epatch "${FILESDIR}"/${P}-findcg-cmake.patch
# ###	epatch "${FILESDIR}"/${P}-assistant.patch
# ###	epatch "${DISTDIR}"/${P}-openfoam-r173.patch.bz2
# ###	epatch "${DISTDIR}"/${P}-openfoam-gpl-r173.patch.bz2
# ###	epatch "${FILESDIR}"/${P}-no-doc-finder.patch
# ###	epatch "${FILESDIR}"/${P}-pointsprite-disable.patch
# ###	epatch "${FILESDIR}"/${P}-about.html.patch
# ###	epatch "${FILESDIR}"/${P}-boost-property_map.patch
# ###	epatch "${FILESDIR}"/${P}-odbc.patch
# ###	epatch "${FILESDIR}"/${P}-h5part.patch
# ###	if has_version '>=sci-libs/hdf5-1.8.0'; then
# ###		epatch "${FILESDIR}"/${P}-hdf-1.8.3.patch
# ###		epatch "${FILESDIR}"/${P}-xdmf2-latest.patch
# ###		epatch "${FILESDIR}"/${P}-xdmf2-directory.patch
# ####		epatch "${FILESDIR}"/${P}-xdmf3-test.patch
# ###	fi
# ##
# ##	# fix GL issues
# ##	sed -e "s:DEPTH_STENCIL_EXT:DEPTH_COMPONENT24:" \
# ##		-i VTK/Rendering/vtkOpenGLRenderWindow.cxx \
# ##		|| die "Failed to fix GL issues."
# ##
# ##	# fix plugin install directory
# ##	sed -e "s:\${PV_INSTALL_BIN_DIR}/plugins:/usr/${PVLIBDIR}/plugins:" \
# ##		-i CMake/ParaViewPlugins.cmake \
# ##		|| die "Failed to fix plugin install directories"
# }

src_configure() {
	export LD_LIBRARY_PATH=${LIBRARY_PATH}
	einfo $LD_LIBRARY_PATH
	mycmakeargs=(
	  -DPV_INSTALL_LIB_DIR="${PVLIBDIR}"
#-DCMAKE_INSTALL_PREFIX=/usr 
	  -DCMAKE_INSTALL_PREFIX=/usr
#-DCMAKE_INSTALL_PREFIXD=${D}usr
	  -DEXPAT_INCLUDE_DIR=/usr/include
	  -DEXPAT_LIBRARY=/usr/$(get_libdir)/libexpat.so
	  -DOPENGL_gl_LIBRARY=/usr/$(get_libdir)/libGL.so
	  -DOPENGL_glu_LIBRARY=/usr/$(get_libdir)/libGLU.so
	  -DCMAKE_USE_RELATIVE_PATHS=ON
	  -DCMAKE_SKIP_RPATH=YES
	  -DVTK_USE_RPATH=OFF
	  -DBUILD_SHARED_LIBS=ON
	  -DCMAKE_BUILD_TYPE=Release
	  -DVTK_USE_SYSTEM_FREETYPE=ON
	  -DVTK_USE_SYSTEM_JPEG=OFF
#-DVTK_USE_SYSTEM_PNG=ON
	  -DVTK_USE_SYSTEM_TIFF=ON
	  -DVTK_USE_SYSTEM_ZLIB=ON
	  -DVTK_USE_SYSTEM_EXPAT=ON
	  -DCMAKE_VERBOSE_MAKEFILE=OFF
	  -DCMAKE_COLOR_MAKEFILE=TRUE
	  -DVTK_USE_SYSTEM_LIBXML2=ON
	  -DVTK_USE_OFFSCREEN=ON
	  -DVTK_USE_MANGLE_MESA=OFF
	  -DCMAKE_USE_PTHREADS=ON
	  -DBUILD_TESTING=OFF
	  -DPARAVIEW_USE_SYSTEM_HDF5=OFF
	  -DPARAVIEW_INSTALL_THIRD_PARTY_LIBRARIES=ON
#-DPARAVIEW_INSTALL_THIRD_PARTY_LIBRARIES=OFF
	  -DVTK_USE_FFMPEG_ENCODER=OFF)

##-DPARAVIEW_EXTERNAL_PLUGIN_DIRS="${PVLIBDIR}/plugins"

	# use flag triggered options
	mycmakeargs+=(
	  $(cmake-utils_use gui PARAVIEW_BUILD_QT_GUI)
	  $(cmake-utils_use gui VTK_USE_QVTK)
	  $(cmake-utils_use gui VTK_USE_QVTK_QTOPENGL)
#$(cmake-utils_use boost VTK_USE_BOOST)
	  $(cmake-utils_use gl2ps VTK_USE_GL2PS)
	  $(cmake-utils_use mpi PARAVIEW_USE_MPI)
	  $(cmake-utils_use python PARAVIEW_ENABLE_PYTHON)
	  $(cmake-utils_use doc BUILD_DOCUMENTATION)
	  $(cmake-utils_use examples BUILD_EXAMPLES)
	  $(cmake-utils_use cg VTK_USE_CG_SHADERS)
	  $(cmake-utils_use streaming PARAVIEW_BUILD_StreamingParaView)
	  $(cmake-utils_use odbc VTK_USE_ODBC)
	  $(cmake-utils_use mysql VTK_USE_MYSQL)
	  $(cmake-utils_use mysql XDMF_USE_MYSQL)
#$(cmake-utils_use osmesa VTK_OPENGL_HAS_OSMESA)
	  $(cmake-utils_use postgres VTK_USE_POSTGRES))
	mycmakeargs+=(
	  $(cmake-utils_use gui MODULE_VTKIOVIDEO)
	  $(cmake-utils_use gui MODULE_VISITLIB)
	  $(cmake-utils_use gui MODULE_PQPYTHON)
	  $(cmake-utils_use gui MODULE_VTKFILTERSIMAGING)
	  $(cmake-utils_use gui MODULE_VTKFILTERSPARALLELFLOWPATHS)
	  $(cmake-utils_use gui MODULE_VTKFILTERSPARALLELGEOMETRY)
	  $(cmake-utils_use gui MODULE_VTKFILTERSPARALLELIMAGING)
	  $(cmake-utils_use gui MODULE_VTKFILTERSPARALLELMPI)
	  $(cmake-utils_use gui MODULE_VTKFILTERSREEBGRAPH)
	  $(cmake-utils_use gui MODULE_VTKFILTERSSELECTION)
	  $(cmake-utils_use gui MODULE_VTKGUISUPPORTQTOPENGL)
	  $(cmake-utils_use gui MODULE_VTKGUISUPPORTQTWEBKIT)
	  $(cmake-utils_use gui MODULE_VTKGEOVISCORE)
	  $(cmake-utils_use gui MODULE_VTKIOMINC)
	  $(cmake-utils_use gui MODULE_VTKIOMPIIMAGE)
	  $(cmake-utils_use gui MODULE_VTKIOPARALLELNETCDF)
	  $(cmake-utils_use gui MODULE_VTKIOVIDEO)
	  $(cmake-utils_use gui MODULE_VTKIOVISITBRIDGE)
	  $(cmake-utils_use gui MODULE_VTKIMAGINGMATH)
	  $(cmake-utils_use gui MODULE_VTKIMAGINGSTATISTICS)
	  $(cmake-utils_use gui MODULE_VTKIMAGINGSTENCIL)
	  $(cmake-utils_use gui MODULE_VTKINFOVISBOOST)
	  $(cmake-utils_use gui MODULE_VTKINFOVISBOOSTGRAPHALGORITHMS)
	  $(cmake-utils_use gui MODULE_VTKINFOVISLAYOUT)
	  $(cmake-utils_use gui MODULE_VTKINFOVISPARALLEL)
	  $(cmake-utils_use gui MODULE_VTKRENDERINGFREETYPEFONTCONFIG)
	  $(cmake-utils_use gui MODULE_VTKRENDERINGIMAGE)
	  $(cmake-utils_use gui MODULE_VTKRENDERINGMATPLOTLIB)
	  $(cmake-utils_use gui MODULE_VTKRENDERINGQT)
	  $(cmake-utils_use gui MODULE_VTKUTILITIESCOLORSERIESTOXML)
	  $(cmake-utils_use gui MODULE_VTKVIEWSGEOVIS)
	  $(cmake-utils_use gui MODULE_VTKVIEWSINFOVIS)
	  $(cmake-utils_use gui MODULE_VTKVIEWSQT)
	  )

	if use gui; then
		mycmakeargs+=(-DVTK_INSTALL_QT_DIR=/${PVLIBDIR}/plugins/designer)
	fi


	if use python; then
	  mycmakeargs+=($(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_pvblot))
	fi

	# we also need to append -DH5Tget_array_dims_vers=1 to our CFLAGS
	# to make sure we can compile against >=hdf5-1.8.3
	#append-flags -DH5_USE_16_API

#CMAKE_BUILD_TYPE=Debug
	cmake-utils_src_configure
# overview needs a second configure to pick things up
#use overview && cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	cd ${CMAKE_BUILD_DIR}
	insinto "${EPREFIX}/usr/share/${P}/"
	doins ParaViewConfig.cmake
}

