# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5,3_6} pypy )

inherit distutils-r1

DESCRIPTION="The original source code was part of bibserver from okfn http://github.com/okfn/bibserver This project is released under the AGPLv3. Okfn and the original authors kindly provided the permission to use a subpart of their project (ie the bibtex parser) under LGPLv3. Many thanks to them!

The aim of this project is to provide a standalone library in python."
HOMEPAGE="http://pybtex.org/"
#SRC_URI="https://pypi.python.org/pypi/pybtex"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"


RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-3.0.1[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"


python_compile_all() {
	use doc && emake -C doc html
}

