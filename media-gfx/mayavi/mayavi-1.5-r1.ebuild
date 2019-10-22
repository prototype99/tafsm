# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="MayaVi-$PV"
DESCRIPTION="The MayaVi Data Visualizer"
HOMEPAGE="http://mayavi.sourceforge.net/"
SRC_URI="http://jaist.dl.sourceforge.net/sourceforge/mayavi/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="python"

RDEPEND=">=sys-libs/glibc-2.3.2
	sci-libs/vtk
	virtual/opengl
	>=dev-lang/python-2.0"

DEPEND="${RDEPEND}"

DESTTREE="/usr/local"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
}

src_test() {
	cd ${S}/doc
	python ./test_vtk.py
}

src_compile() {
	cd ${S}
	python ./setup.py build
}

src_install() {
	cd ${S}
	python ./setup.py install_lib
	python ./setup.py install_headers
	python ./setup.py install_data
	cd ${S}/build/scripts-2.4
	dobin mayavi || die "doins mayavi failed"
	dobin vtk_doc.py || die "doins vtk_doc.py failed"
}

