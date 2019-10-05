# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 python3_5 python3_6 python3_7 )
inherit distutils-r1 git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/pybind/pybind11"
EGIT_REPO_URI="https://github.com/pybind/pybind11"
EGIT_TAG="v2.4.2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
