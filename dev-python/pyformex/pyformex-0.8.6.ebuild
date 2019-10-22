# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils flag-o-matic

DESCRIPTION="pyFormex is a program for generating, transforming and manipulating large geometrical models of 3D structures by sequences of mathematical operations."
HOMEPAGE="http://www.nongnu.org/pyformex/"
SRC_URI="http://download.savannah.gnu.org/releases/pyformex/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/pyopengl dev-python/numpy dev-python/PyQt4"
RDEPEND="${DEPEND}"
src_configure() {
	append-flags "-I$(python_get_sitedir)/numpy/core/include"
}

