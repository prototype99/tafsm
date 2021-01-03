# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 python3_7 python3_8 )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc test"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
