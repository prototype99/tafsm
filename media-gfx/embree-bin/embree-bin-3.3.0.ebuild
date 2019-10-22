# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator
DESCRIPTION="High Performance Ray Tracing Kernels"
HOMEPAGE="https://embree.github.io"
SRC_URI="https://github.com/embree/embree/releases/download/v3.3.0/embree-3.3.0.x86_64.linux.tar.gz"

LICENSE="Apache 2.0 license"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-cpp/tbb
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"
src_compile() {
	:
}
src_install() {
	dodir /opt/embree-3.3
	cp -aR "${S}"/embree-3.3.0.x86_64.linux/* "${ED}"/opt/embree-3
}

