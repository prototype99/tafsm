# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/ispc/ispc/releases/download/v${PV}/ispc-v${PV}b-linux.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!dev-lang/ispc"
RDEPEND="${DEPEND}"
BDEPEND=""
#S="${WORKDIR}"
S="${WORKDIR}/ispc-v${PV}-linux"

src_install() {
	dobin bin/ispc
}

