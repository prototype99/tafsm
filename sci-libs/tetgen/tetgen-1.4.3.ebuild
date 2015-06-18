# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils flag-o-matic

DESCRIPTION="A Quality Tetrahedral Mesh Generator and a 3D Delaunay Triangulator"
HOMEPAGE="http://wias-berlin.de/software/tetgen/"
SRC_URI="http://tetgen.org/files/tetgen1.4.3.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}${PV}"

src_compile(){
	emake
	emake tetlib
}

src_install(){
	dobin tetgen
	dolib.a libtet.a
}
