# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#NEED_PYTHON=2.4

inherit distutils

MY_P=pyplusplus-${PV}

DESCRIPTION="Object-oriented framework for creating a code generator for Boost.Python library."
HOMEPAGE="http://www.language-binding.net/"
SRC_URI="mirror://sourceforge/pygccxml/${MY_P}.zip"

LICENSE="freedist Boost-1.0"
SLOT="0"
IUSE="doc examples"
KEYWORDS="amd64 ~x86"

RDEPEND=">=dev-python/pygccxml-1.0.0"

DEPEND="virtual/python
    doc? ( >=dev-python/epydoc-3 )"

S="${WORKDIR}/Py++-${PV}"

src_install() {
	distutils_src_install

	if use doc; then
	    "${python}" setup.py doc
		dohtml -r docs/documentation/apidocs/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	PYTHONPATH="./unittests/" "${python}" unittests/test_all.py || die "tests failed"
}
