# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit eutils libtool toolchain-funcs cmake-utils

DESCRIPTION="Netgen is a multi-platform automatic mesh generation tool written
in C++ capable of generating meshes in two and three dimensions."
HOMEPAGE="http://sourceforge.net/apps/mediawiki/netgen-mesher/"
SRC_URI="https://github.com/NGSolve/netgen/archive/v${PV}.tar.gz"
#S="${WORKDIR}/${P}-RC"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64"
IUSE="occ"

DEPEND="
	dev-lang/tcl
	dev-lang/tk
	dev-tcltk/tix
	>=dev-tcltk/togl-1.7
	dev-python/pybind11
	dev-haskell/glut
	occ?  ( sci-libs/opencascade )
"
RDEPEND="${DEPEND}"

#PATCHES=(
#  "${FILESDIR}/${P}-togl.patch"
#)
#src_configure(){
##eautoreconf --install
#	elibtoolize
#	myconfig="--prefix=${EPREFIX}/usr"
#	if use occ ; then
#	  myconfig="${myconfig} --enable-occ"
#	fi
#	econf ${myconfig}
##	--enable-occ            compile with OpenCascade geometry kernel
##	--enable-nglib          generate shared library nglib
##	--enable-parallel       enable mpi parallelization
##	--enable-jpeglib        enable snapshots using library libjpeg
##	--enable-ffmpeg         enable video recording with FFmpeg, uses
##	libavcodec
#
#}
#

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

#src_compile(){
#	emake DESTDIR=${D}
#}
#
#src_install(){
#	emake DESTDIR=${D} install
#}
