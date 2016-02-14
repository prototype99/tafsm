# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Pybtex is a BibTeX-compatible bibliography processor written in Python.
You can simply type pybtex instead of bibtex."
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

