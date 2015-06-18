# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit distutils eutils libtool flag-o-matic toolchain-funcs versionator

DESCRIPTION="Netgen is a multi-platform automatic mesh generation tool written
in C++ capable of generating meshes in two and three dimensions."
HOMEPAGE="http://sourceforge.net/apps/mediawiki/netgen-mesher/"
SRC_URI="http://sourceforge.net/projects/netgen-mesher/files/netgen-mesher/${PV}/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64"
IUSE="occ"

DEPEND="
	dev-lang/tcl
	dev-lang/tk
	dev-tcltk/tix
	~dev-tcltk/togl-1.7
	dev-haskell/glut
	occ?  ( sci-libs/opencascade )
"
RDEPEND="${DEPEND}"


src_configure(){
#eautoreconf --install
	elibtoolize
	myconfig="--prefix=${EPREFIX}/usr"
	if use opencascade ; then
	  myconfig="${myconfig} --enable-occ"
	fi

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
