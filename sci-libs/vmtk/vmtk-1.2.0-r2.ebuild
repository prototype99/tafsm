# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils flag-o-matic toolchain-funcs python cmake-utils git-2 versionator

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
IUSE="vtk"

DEPEND="
		>=dev-util/cmake-2.8
		>=dev-lang/python-2.6
		vtk? ( =sci-libs/vtk-5.10.0 )
"

RDEPEND="
		>=dev-lang/python-2.7
		vtk? ( =sci-libs/vtk-5.10.0 )
"
EGIT_REPO_URI="https://github.com/vmtk/vmtk.git"
EGIT_COMMIT="v$(get_version_component_range 1-2 $PV)"
PYTHON_MODNAME="vmtk"

RDEPEND="${DEPEND}"
src_unpack() {
	git-2_src_unpack

#	if use vtk; then
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
	mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_INSTALL_LIBDIR=/opt/vmtk/lib64
		-DCMAKE_INSTALL_PREFIX=/opt/vmtk
		-DVMTK_WITH_LIBRARY_VERSION=ON
		)
#	if use vtk; then
#		mycmakeargs+=(-DUSE_SYSTEM_VTK=ON )
#	fi
	cmake-utils_src_configure
}
src_install() {
	elog "Install: ${PWD}"
	cd "${CMAKE_BUILD_DIR}/Install"
	elog "Install: ${CMAKE_BUILD_DIR}"


#into /usr/$(get_libdir)/ITK
	insinto "${EPREFIX}/usr/share/${P}/lib/InsightToolkit"
	find "lib" -type f -name "libITK*" | while read f ; do
	elog "Install: ${f}"
		doins $f 
	done

	find "lib" -type f -name "libitk*" | while read f ; do
#dolib $f 
	elog "Install: ${f}"
		doins $f 
	done



#	find "Install/lib/InsightToolkit/" -type f -not -name "*.cmake" | while read f ; do
#		dolib ${f}
#	done
#	find "Install/lib/InsightToolkit/" -type l | while read f ; do
#		dolib $f
#	done

	insinto $(python_get_sitedir)/vmtk
	find "lib/vmtk/vmtk" -type f | while read f ; do
		doins ${f}
	done
	find "lib/vmtk/" -type f -maxdepth 1 -not -name "*.py" | while read f ; do
		dolib $f
	done

#dobin Install/bin/vmtk
	exeinto "${EPREFIX}/usr/share/${P}/bin"
	find "bin/" -type f -not -name "vmtk" | while read f ; do
		doexe ${f}
	done
	doexe bin/vmtk
	dosym ${EPREFIX}/usr/share/${P}/bin/vmtk ${EPREFIX}/usr/bin/vmtk

	if use vtk ; then
		:
	else
	    insinto "${EPREFIX}/usr/share/${P}/lib/vtk-5.10"
		find "lib/vtk-5.10" -type f -name "libvtk*" | while read f ; do
		elog "Install: ${f}"
			j=`basename $f .0`
			newins $f $j
		done
	fi

}


