# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
PYTHON_COMPAT=( python2_7 python3_4 python3_5 python3_6 )

#inherit eutils flag-o-matic toolchain-funcs cmake-utils versionator git-r3 python-r1
inherit cmake-utils git-r3  versionator python-single-r1 

DESCRIPTION="Segmentation of vascular segments (or other anatomical structures)
from medical images:
Gradient-based 3D level sets segmentation. A new gradient computation modality
based on upwind finite differences allows the segmentation of small (down to 1.2 pixels/diameter) vessels.
Interactive level sets initialization based on the Fast Marching Method. This
includes a brand new method for selecting a vascular segment comprised between
two points automatically ignoring side branches, no parameters involved.
Segmenting a complex vascular tract comes down to selecting the endpoints of a
branch, letting level sets by attracted to gradient peaks with the sole
advection term turned on, repeating the operation for all the branches and
merging everything in a single model."

HOMEPAGE="http://www.vmtk.org/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
#IUSE="vtk"

DEPEND="\
		>=dev-util/cmake-2.8
		>=sci-libs/vtk-8.1.1
"

EGIT_REPO_URI="https://github.com/vmtk/vmtk.git"
EGIT_COMMIT="v$(get_version_component_range 1-3 $PV)"
#EGIT_MASTER="vtk"
#PYTHON_MODNAME="vmtk"
RDEPEND="${DEPEND}"
#src_prepare() {
#	:
#}
src_unpack() {
	git-r3_src_unpack

	#if use vtk; then
	#	:
	#else
	#	epatch "${FILESDIR}/vtk-path-${PV}.patch"
	#fi
	#epatch "${FILESDIR}/ITK-shared-lib.patch"
#		v=$(best_version sci-libs/vtk)
#		v=${v#sci-libs/vtk-}
#		v=vtk-$(get_version_component_range 1-2 $v)
#		elog "Setting vtk version: $v"
##epatch "${FILESDIR}/vtk-path-${PV}.patch"
#		sed -i -e "s/vtk-5.10/$v/" ${S}/PypeS/pyperun.py || die "sed failed"
#		sed -i -e "s/vtk-5.10/$v/" ${S}/vmtk.py || die "sed failed"
#	fi
}

src_configure() {
#		-DCMAKE_INSTALL_LIBDIR=/opt/vmtk/lib64
#		-DCMAKE_INSTALL_PREFIX=/opt/vmtk

	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DVMTK_WITH_LIBRARY_VERSION=ON
		-DVMTK_USE_X=ON
		-DBUILD_SHARED_LIBS=ON
		-DUSE_SYSTEM_ITK=NO 
		#-DUSE_SYSTEM_VTK=YES
		-DUSE_SYSTEM_VTK=NO
		)
		#-DITK_USE_FLAT_DIRECTORY_INSTALL=OFF
	#if use vtk; then
	#	mycmakeargs+=(-DUSE_SYSTEM_VTK=ON )
	#fi
	cmake-utils_src_configure
}
pkg_setup() {
	python-single-r1_pkg_setup
	PYSITE=$(python_get_sitedir)
	SITE="${EPYTHON}/site-packages"
}


src_install() {
	elog "Install: ${PWD}"
	cd "${CMAKE_BUILD_DIR}/Install"
	elog "Install: ${CMAKE_BUILD_DIR}"


#into /usr/$(get_libdir)/ITK
	insinto "${EPREFIX}/usr/share/${P}/$(get_libdir)/InsightToolkit"
	find "lib" -type f -name "libITK*" | while read f ; do
	elog "Install: ${f}"
		doins $f 
	done

	find "lib" -type f -name "libitk*" | while read f ; do
#dolib $f 
	elog "Install: ${f}"
		doins $f 
	done

	insinto "${EPREFIX}/usr/$(get_libdir)"
	find "lib" -type f -name "libvtkvmtk*" | while read f ; do
#dolib $f 
	elog "Install: ${f}"
		doins $f 
	done



#dobin Install/bin/vmtk
	exeinto "${EPREFIX}/usr/share/${P}/bin"
	find "bin/" -type f -not -name "vmtk" -maxdepth 1| while read f ; do
		doexe ${f}
	done
	doexe bin/vmtk
	dosym ${EPREFIX}/usr/share/${P}/bin/vmtk ${EPREFIX}/usr/bin/vmtk

	#python_foreach_impl installation
	#elog "$(python_get_sitedir)/vmtk"
	insinto "${PYSITE}/vmtk"
	find "lib/${SITE}/vmtk" -type f | while read f ; do
		doins ${f}
	done
	find "lib/${SITE}/vmtk/" -type f -name "vtkvmtk*.so" -maxdepth 1 -not -name "*.py" | while read f ; do
		doins $f
	done

	#find "lib/python2_7/site-packages/vmtk/" -type f -name "lib*" -maxdepth 1 -not -name "*.py" | while read f ; do
	#	dolib $f
	#done

#	if use vtk ; then
#		:
#	else
#	    insinto "${EPREFIX}/usr/share/${P}/lib/vtk-5.10"
#		find "lib/vtk-5.10" -not -type d -name "lib*" | while read f ; do
#			doins $f
#		done
#		insinto "${EPREFIX}/usr/share/${P}/bin/Python"
#		find "lib/vtk-5.10" -not -type d -name "vtk*.so" | while read f ; do
#			doins $f
#		done
#		cd "${CMAKE_BUILD_DIR}/Install/bin/Python"
#
#		find "vtk" -type f  | while read f ; do
#			d=`dirname $f`
#			insinto "${EPREFIX}/usr/share/${P}/bin/Python/$d"
#			doins ${f}
#		done
#	fi
#exit -1

}


#src_install() {
#	cmake-utils_src_install
#	elog "Install: ${PWD}"
#	cd "${CMAKE_BUILD_DIR}/Install"
#	elog "Install: ${CMAKE_BUILD_DIR}"
#
#
##into /usr/$(get_libdir)/ITK
#	insinto "${EPREFIX}/usr/share/${P}/lib/"
#	find "lib" -type f -name "libITK*" | while read f ; do
#		doins $f 
#	done
#
#	find "lib" -type f -name "libitk*" | while read f ; do
##dolib $f 
#		doins $f 
#	done
#
#	insinto $(python_get_sitedir)/vmtk
#	find "lib/vmtk/vmtk" -type f | while read f ; do
#		doins ${f}
#	done
#	insinto $(python_get_sitedir)/
#	find "lib/vmtk/" -type f -maxdepth 1 -not -name "*.py" | while read f ; do
#		dolib $f
#	done
#
##dobin Install/bin/vmtk
#	exeinto "${EPREFIX}/usr/share/${P}/bin"
#	find "bin/" -type f -not -name "vmtk" -maxdepth 1| while read f ; do
#		doexe ${f}
#	done
#	doexe bin/vmtk
#	dosym ${EPREFIX}/usr/share/${P}/bin/vmtk ${EPREFIX}/usr/bin/vmtk
#
#	if use vtk ; then
#		:
#	else
#	    insinto "${EPREFIX}/usr/share/${P}/lib/"
#		find "lib/vtk-5.10" -not -type d -not -name "*.cmake" | while read f ; do
#			doins $f
#		done
#
#		cd "${CMAKE_BUILD_DIR}/Install/bin/Python"
#		find "vtk" -type f  | while read f ; do
#			d=`dirname $f`
#			insinto "${EPREFIX}/usr/share/${P}/lib/vtk-5.10/$d"
#			doins ${f}
#		done
#	fi
#exit -1
#
#}


