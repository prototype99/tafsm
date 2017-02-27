# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

DESCRIPTION="Read, modify and write DICOM files with python code"
HOMEPAGE="https://github.com/darcymason/pydicom"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"
RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
"
