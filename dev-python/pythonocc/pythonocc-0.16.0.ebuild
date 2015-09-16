# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils cmake-utils

MY_PN=pythonocc-core
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python Interface to OpenCASCADE CAD library"
HOMEPAGE="http://www.pythonocc.org"
#SRC_URI="http://download.gna.org/${PN}/${PV}/${MY_P}.tar.gz"
SRC_URI="https://github.com/tpaviot/pythonocc-core/archive/${PV}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="sci-libs/opencascade
	>=dev-lang/swig-2.0.10
	>=dev-util/cmake-2.8
"
DEPEND="${RDEPEND}
	dev-lang/swig"

#RESTRICT_PYTHON_ABIS="3.*"

S=${WORKDIR}/${MY_P}/
