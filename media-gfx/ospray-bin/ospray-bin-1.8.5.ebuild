# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator
DESCRIPTION="A Ray Tracing Based Rendering Engine for High-Fidelity Visualization"
HOMEPAGE="http://www.ospray.org"
SRC_URI="https://github.com/ospray/OSPRay/releases/download/v${PV}/ospray-${PV}.x86_64.linux.tar.gz"
LICENSE=""
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
	dodir /opt/ospray-1.8
	cp -aR "${S}"/ospray-${PV}.x86_64.linux/* "${ED}"/opt/ospray-1.8
}

