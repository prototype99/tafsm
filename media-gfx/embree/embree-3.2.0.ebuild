# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils multilib versionator cmake-utils
DESCRIPTION="High Performance Ray Tracing Kernels"
HOMEPAGE="https://embree.github.io"
SRC_URI="https://github.com/embree/embree/archive/v3.2.0.tar.gz"

LICENSE="Apache 2.0 license"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-cpp/tbb
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
	-DEMBREE_ISPC_SUPPORT=OFF
	-EMBREE_MAX_ISA=NONE
	)
	cmake-utils_src_configure
}
