# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_4 python3_5 python3_6)
inherit eutils multilib versionator python-single-r1 cmake-utils

MAIN_PV=$(get_major_version)
MAJOR_PV=$(get_version_component_range 1-2)
MY_P="ParaView-v${PV}"

DESCRIPTION="ParaView is a powerful scientific data visualization application"
HOMEPAGE="http://www.paraview.org"
SRC_URI="http://www.paraview.org/files/v${MAJOR_PV}/${MY_P}.tar.gz"
RESTRICT="mirror"

LICENSE="paraview GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="cg coprocessing development doc examples mpi xdmf3 mysql nvcontrol openmp plugins python qt4 qt5 sqlite tcl test tk debug osmesa"
RESTRICT="test"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
	mysql? ( sqlite )
	^^ ( qt4 qt5 )" # "vtksqlite, needed by vtkIOSQL" and "vtkIOSQL, needed by vtkIOMySQL"

#>=x11-libs/gl2ps-1.3.8

RDEPEND="
	dev-libs/expat
	dev-libs/libxml2:2
	dev-libs/protobuf
	media-libs/freetype
	media-libs/libpng:0
	media-libs/libtheora
	media-libs/tiff:0=
	sys-libs/zlib
	virtual/jpeg:0
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXt
	coprocessing? (
		plugins? (
			qt4? (
				dev-python/PyQt4
				dev-qt/qtgui:4
				
			qt5? (
				dev-python/PyQt5
				dev-qt/qtgui:5
				)
			)
		)
	)
	mpi? ( virtual/mpi[cxx,romio] )
	mysql? ( virtual/mysql )
	dev-python/pygments[${PYTHON_USEDEP}]
	python? (
		${PYTHON_DEPS}
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/sip[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		mpi? ( dev-python/mpi4py[${PYTHON_USEDEP}] )
		qt5? ( dev-python/PyQt5[opengl,webkit,${PYTHON_USEDEP}] )
		qt4? ( dev-python/PyQt4[opengl,webkit,${PYTHON_USEDEP}] )
	)
	qt5? (
		dev-qt/designer:5
		dev-qt/qtgui:5
		dev-qt/qtopengl:5
		dev-qt/qthelp:5
		dev-qt/qtsql:5
		dev-qt/qtwebkit:5
		dev-qt/qttest:5
		dev-qt/qtxmlpatterns:5
		lxqt-base/liblxqt
	)
	qt4? (
		dev-qt/designer:4
		dev-qt/qtgui:4
		dev-qt/qtopengl:4
		dev-qt/qthelp:4
		dev-qt/qtsql:4
		dev-qt/qtwebkit:4
		dev-qt/qttest:4
		lxqt-base/liblxqt
	)
	sqlite? ( dev-db/sqlite:3 )
	tcl? ( dev-lang/tcl:0= )
	tk? ( dev-lang/tk:0= )"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_P}"

#PATCHES=(
#	"${FILESDIR}/${P}_all_protected.patch"
#)
pkg_setup() {
	python-single-r1_pkg_setup
	PVLIBDIR=$(get_libdir)/${PN}-${MAJOR_PV}
	#PARAVIEW_VERSION="${MAJOR_PV}"
	#ParaView_BINARY_DIR="${WORKDIR}/paraview-${PV}_build"
}

src_prepare() {
	default
	cmake-utils_src_prepare
	epatch "${FILESDIR}/${P}_all_protected.patch"
	
	sed -i \
		-e "s:lib/paraview-:$(get_libdir)/paraview-:g" \
		ParaViewCore/ServerManager/SMApplication/vtkInitializationHelper.cxx \
		CMake/ParaViewPlugins.cmake || die

	# no proper switch
	use nvcontrol || {
		sed -i \
			-e '/VTK_USE_NVCONTROL/s#1#0#' \
			VTK/Rendering/OpenGL/CMakeLists.txt || die
	}
	# lib64 fixes
	sed -i \
		-e "s:/lib/python:/$(get_libdir)/python:g" \
		VTK/ThirdParty/xdmf3/vtkxdmf3/CMakeLists.txt || die
	sed -i \
		-e "s:lib/paraview-:$(get_libdir)/paraview-:g" \
		ParaViewCore/ServerManager/SMApplication/vtkInitializationHelper.cxx || die
}

src_configure() {
	if use qt5; then
		export QT_SELECT=qt5
	fi
	# VTK_USE_SYSTEM_QTTESTING
	# PARAVIEW_USE_SYSTEM_AUTOBAHN
	CMAKE_BUILD_TYPE="Release"
	#CMAKE_LIBRARY_OUTPUT_DIRECTORY=${CMAKE_BINARY_DIR}
	#-DVTK_INSTALL_ARCHIVE_DIR="$(get_libdir)"
	#-Dverdict_INSTALL_LIBRARY_DIR="$(get_libdir)"
	#-DMETAIO_INSTALL_LIBRARY_DIR="$(get_libdir)"
	#-DKWSYS_INSTALL_LIB_DIR=$(get_libdir)"
	#elog "	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=${ParaView_BINARY_DIR}/$(get_libdir)""
	#elog "	-DVTK_INSTALL_LIBRARY_DIR=$(get_libdir)"
	#elog "	-DVTK_INSTALL_ARCHIVE_DIR=$(get_libdir)"
	#elog "	-DVTK_INSTALL_PACKAGE_DIR=$(get_libdir)/cmake/paraview-${PARAVIEW_VERSION}"
	#elog "	-DPV_INSTALL_LIB_DIR=${PVLIBDIR}"
	#elog "	-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
	#elog "	-DEXPAT_INCLUDE_DIR=${EPREFIX}/usr/include"
	#elog "	-DEXPAT_LIBRARY=${EPREFIX}/usr/$(get_libdir)/libexpat.so"
	#elog "	-DOPENGL_gl_LIBRARY=${EPREFIX}/usr/$(get_libdir)/libGL.so"
	#elog "	-DOPENGL_glu_LIBRARY=${EPREFIX}/usr/$(get_libdir)/libGLU.so"
	#elog "	-DBUILD_SHARED_LIBS=ON"
	#CMAKE_INSTALL_RPATH_USE_LINK_PATH

	local mycmakeargs=(
		#-DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON
		#-DCMAKE_LIBRARY_OUTPUT_DIRECTORY="${ParaView_BINARY_DIR}/$(get_libdir)"
		#-DVTK_INSTALL_LIBRARY_DIR="$(get_libdir)"
		#-DVTK_INSTALL_PACKAGE_DIR="$(get_libdir)/cmake/paraview-${PARAVIEW_VERSION}"
		#-DPV_INSTALL_LIB_DIR="${PVLIBDIR}"
		#-DEXPAT_INCLUDE_DIR="include/paraview-${PARAVIEW_VERSION}"
		-DCMAKE_INSTALL_LIBDIR="${PVLIBDIR}"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DEXPAT_INCLUDE_DIR="${EPREFIX}"/usr/include
		-DEXPAT_LIBRARY="${EPREFIX}"/usr/$(get_libdir)/libexpat.so
		-DOPENGL_gl_LIBRARY="${EPREFIX}"/usr/$(get_libdir)/libGL.so
		-DOPENGL_glu_LIBRARY="${EPREFIX}"/usr/$(get_libdir)/libGLU.so
		-DBUILD_SHARED_LIBS=ON
		-DVTK_Group_StandAlone=ON
		-DVTK_RENDERING_BACKEND=OpenGL2
		-DVTK_USE_SYSTEM_LIBPROJ4:BOOL=OFF
		#-DVTK_USE_SYSTEM_EXPAT=ON
		#-DVTK_USE_SYSTEM_FREETYPE=ON
		#-DVTK_USE_SYSTEM_GL2PS=ON
		-DVTK_USE_SYSTEM_HDF5=OFF
		#-DVTK_USE_SYSTEM_JPEG=ON
		-DVTK_USE_SYSTEM_JSONCPP=OFF
		#-DVTK_USE_SYSTEM_LIBXML2=ON
		-DVTK_USE_SYSTEM_NETCDF=OFF
		#-DVTK_USE_SYSTEM_OGGTHEORA=ON
		#-DVTK_USE_SYSTEM_PNG=ON
		-DVTK_USE_SYSTEM_PROTOBUF=ON
		-DVTK_USE_SYSTEM_PYGMENTS=ON
		#-DVTK_USE_SYSTEM_TIFF=ON
		#$(usex xdmf2 "-DVTK_USE_SYSTEM_XDMF2=ON" "-DVTK_USE_SYSTEM_XDMF2=OFF")
		#-DVTK_USE_SYSTEM_ZLIB=ON
		#-DVTK_USE_SYSTEM_ZOPE=ON
		-DVTK_USE_SYSTEM_ZOPE=OFF
		#-DVTK_USE_SYSTEM_TWISTED=ON
		-DVTK_USE_SYSTEM_TWISTED=OFF
		-DCMAKE_VERBOSE_MAKEFILE=ON
		-DCMAKE_COLOR_MAKEFILE=TRUE
		#-DVTK_USE_OFFSCREEN=TRUE
		-DVTK_DEFAULT_RENDER_WINDOW_OFFSCREEN=TRUE
		-DCMAKE_USE_PTHREADS=ON
		-DVTK_USE_FFMPEG_ENCODER=OFF
		-DPROTOC_LOCATION=$(type -P protoc)
		-DVTK_Group_StandAlone=ON
		#-DPARAVIEW_ENABLE_XDMF3=ON
		-DPARAVIEW_ENABLE_XDMF2=$(usex xdmf3 OFF ON)
		-DPARAVIEW_ENABLE_XDMF3=$(usex xdmf3 ON OFF)
		-DModule_vtkIOXdmf2=$(usex xdmf3 OFF ON)
		-DModule_vtkxdmf2=$(usex xdmf3 OFF ON)
		-DModule_vtkxdmf3=$(usex xdmf3 ON OFF)
		-DPARAVIEW_ENABLE_XDMF3=$(usex xdmf3 ON OFF)
		-DModule_vtkIOParallelXdmf3=$(usex xdmf3 ON OFF)
		-DVTK_USE_SYSTEM_XDMF2=OFF
		-DVTK_USE_SYSTEM_XDMF3=OFF
			# force this module due to incorrect build system deps
		# wrt bug 460528
		#-DModule_vtkUtilitiesProcessXML=ON
		-DVTK_PYTHON_VERSION=3
		-DVTK_USE_SYSTEM_SIX:BOOL=OFF
		#-DPARAVIEW_QT_VERSION=5
		-DPARAVIEW_USE_OSPRAY=OFF
		-DVTK_ALL_NEW_OBJECT_FACTORY:BOOL=ON
		-DVTK_DISPATCH_AOS_ARRAYS:BOOL=ON
		-DVTK_DISPATCH_SOA_ARRAYS:BOOL=ON
		-DVTK_DISPATCH_TYPED_ARRAYS:BOOL=ON
		#-DHDF5_BUILD_STATIC_EXECS:BOOL=ON
		-DVTK_PYTHON_FULL_THREADSAFE:BOOL=ON
		-DBUILD_DICOM_PROGRAMS:BOOL=ON
		-DModule_vtkDICOM:BOOL=ON
		-DModule_vtkFiltersImaging:BOOL=ON
		-DModule_vtkFiltersSMP:BOOL=ON
		-DModule_vtkGUISupportQtOpenGL:BOOL=ON
		-DVTK_OPENGL_HAS_OSMESA:BOOL=OFF
		-DPARAVIEW_USE_VTKM=ON
		-DVTKm_ENABLE_OSMESA=ON
		-DModule_vtkUtilitiesProcessXML=ON
		)
		if use python ; then
			if use mpi ; then
				mycmakeargs+=( -DVTK_USE_SYSTEM_MPI4PY=ON )
			fi
		fi

		if use qt4 ; then
			mycmakeargs+=( -DPARAVIEW_QT_VERSION=4 )
			mycmakeargs+=( -DPARAVIEW_BUILD_QT_GUI=ON )
			mycmakeargs+=( -DQT_QMAKE_EXECUTABLE:FILEPATH=/usr/$(get_libdir)/qt4/bin/qmake )
		fi
		if use qt5 ; then
			mycmakeargs+=( -DPARAVIEW_QT_VERSION=5 )
			mycmakeargs+=( -DPARAVIEW_BUILD_QT_GUI=ON )

			mycmakeargs+=( -DQT_QMAKE_EXECUTABLE:FILEPATH=/usr/$(get_libdir)/qt5/bin/qmake )
			mycmakeargs+=( -DQT_XMLPATTERNS_EXECUTABLE:FILEPATH=/usr/$(get_libdir)/qt5/bin/xmlpatterns )
			mycmakeargs+=( -DQT_HELP_GENERATOR:FILEPATH=/usr/$(get_libdir)/qt5/bin/qhelpgenerator)
		fi
		#Module_vtkParallelMPI4Py 
		#PARAVIEW_USE_MPI
		# TODO: XDMF_USE_MYSQL?
		# VTK_WRAP_JAVA
		mycmakeargs+=(
		-DVTK_Group_ParaViewQt="$(usex qt5)"
		-DVTK_Group_Qt="$(usex qt5)"
		#-DModule_vtkGUISupportQtWebkit="$(usex qt5)"
		-DModule_vtkGUISupportQtWebkit=OFF
		-DModule_vtkRenderingQt="$(usex qt5)"
		-DModule_vtkViewsQt="$(usex qt5)"
		-DPARAVIEW_USE_MPI=$(usex mpi)
		-DVTK_Group_MPI=$(usex mpi)
		-DModule_vtkFiltersParallelImaging=$(usex mpi)
		-DModule_vtkFiltersParallelMPI=$(usex mpi)
		-DModule_vtkIOMPIImage=$(usex mpi)
		-DXDMF_BUILD_MPI=$(usex mpi)
		-DVTKm_ENABLE_MPI=$(usex mpi)
		-DVTK_XDMF_USE_MPI=$(usex mpi)
		-DPARAVIEW_ENABLE_PYTHON=$(usex python)
		-DModule_vtkPython=$(usex python)
		-DModule_pqPython=$(usex python)
		-DModule_vtkWrappingPythonCore=$(usex python)
		-DModule_vtkPVPythonSupport=$(usex python)
		#-DXDMF_WRAP_PYTHON="$(usex python)"
		-DBUILD_DOCUMENTATION=$(usex doc)
		-DPARAVIEW_BUILD_WEB_DOCUMENTATION=$(usex doc)
		-DBUILD_EXAMPLES=$(usex examples)
		)
		use debug && CMAKE_BUILD_TYPE=Debug;
		use debug || elog "NoDEBUG";

		#if use xdmf2 ;then
		#	mycmakeargs+=(
		#	-Dxdmf2_DIR:PATH=/usr/share/cmake/Modules
		#	-Dxdmf2_DIR:PATH=/usr/share/cmake/Modules
		#	)
		#fi

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
		if use openmp; then
			mycmakeargs+=( -DVTK_SMP_IMPLEMENTATION_TYPE=OpenMP )
		fi

		cmake-utils_src_configure
	}

	src_compile() {
		cmake-utils_src_compile
	}
	src_install() {
		cmake-utils_src_install

		# remove wrapper binaries and put the actual executable in place
		for i in "${ED}"/usr/bin/*; do
			mv "${ED}"/usr/lib/"$(basename $i)" "$i" || die
		done

		# install libraries into correct directory respecting get_libdir:
		mv "${ED}"/usr/lib "${ED}"/usr/lib_tmp || die
		mkdir -p "${ED}"/usr/"${PVLIBDIR}" || die
		mv "${ED}"/usr/lib_tmp/* "${ED}"/usr/"${PVLIBDIR}" || die
		rmdir "${ED}"/usr/lib_tmp || die

		# set up the environment
		echo "LDPATH=${EPREFIX}/usr/${PVLIBDIR}" > "${T}"/40${PN} || die
		doenvd "${T}"/40${PN}

		newicon "${S}"/Applications/ParaView/pvIcon-32x32.png paraview.png
		make_desktop_entry paraview "Paraview" paraview

		use python && python_optimize "${D}"/usr/$(get_libdir)/${PN}-${MAJOR_PV}
	}

