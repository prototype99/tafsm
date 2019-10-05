# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit eutils libtool toolchain-funcs

DESCRIPTION="Netgen is a multi-platform automatic mesh generation tool written
in C++ capable of generating meshes in two and three dimensions."
HOMEPAGE="http://sourceforge.net/apps/mediawiki/netgen-mesher/"
SRC_URI="http://sourceforge.net/projects/netgen-mesher/files/netgen-mesher/$(ver_cut 1-2)/${P}.tar.gz"
#S="${WORKDIR}/${P}-RC"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64"
IUSE="occ"

DEPEND="
	dev-lang/tcl
	dev-lang/tk
	dev-tcltk/tix
	=dev-tcltk/togl-1.7
	dev-haskell/glut
	occ?  ( sci-libs/opencascade )
"
RDEPEND="${DEPEND}"

PATCHES=(
  "${FILESDIR}/${P}-togl.patch"
)
src_configure(){
#eautoreconf --install
	elibtoolize
	myconfig="--prefix=${EPREFIX}/usr"
	if use occ ; then
	  myconfig="${myconfig} --enable-occ"
	fi
	myconfig="${myconfig} --with-togl=/usr/lib64 "
	econf ${myconfig}
#	--enable-occ            compile with OpenCascade geometry kernel
#	--enable-nglib          generate shared library nglib
#	--enable-parallel       enable mpi parallelization
#	--enable-jpeglib        enable snapshots using library libjpeg
#	--enable-ffmpeg         enable video recording with FFmpeg, uses
#	libavcodec

}

src_compile(){
	emake DESTDIR=${D}
}

src_install(){
	emake DESTDIR=${D} install
}
