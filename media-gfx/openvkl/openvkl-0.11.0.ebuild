# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake-utils
DESCRIPTION="Intel Open Volume Kernel Library (Intel Open VKL) is a collection
of high-performance volume computation kernels, developed at Intel."
HOMEPAGE="https://www.openvkl.org/"
SRC_URI="https://github.com/openvkl/openvkl/archive/v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	|| (
		dev-lang/ispc
		dev-lang/ispc-bin
	)
	media-gfx/embree
	media-gfx/rkcommon
"
RDEPEND="${DEPEND}"
BDEPEND=""
src_configure() {
	#local mycmakeargs=(
	##-DEMBREE_ISPC_SUPPORT=OFF
	##-DEMBREE_MAX_ISA=NONE
	##-EMBREE_IGNORE_CMAKE_CXX_FLAGS=OFF
	#)
	cmake-utils_src_configure
}
