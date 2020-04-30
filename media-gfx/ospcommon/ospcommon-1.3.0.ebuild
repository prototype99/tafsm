# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake-utils
DESCRIPTION="Base C++ infrastructure to support OSPRay"
HOMEPAGE="https://github.com/ospray/ospcommon"
SRC_URI="https://github.com/ospray/ospcommon/archive/v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=False
	)
	cmake-utils_src_configure
}
