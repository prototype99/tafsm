# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="The world's simplest facial recognition api for Python and the command line"
HOMEPAGE="https://github.com/ageitgey/face_recognition"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc test"

RDEPEND="\
dev-python/pillow
sci-libs/dlib
>=dev-python/face_recognition_models-0.3.0
>=sci-python/numpy-19.7
>=dev-python/click-6.0
"
DEPEND="${RDEPEND}"

