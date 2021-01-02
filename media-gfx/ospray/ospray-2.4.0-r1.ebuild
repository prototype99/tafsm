# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake-utils
DESCRIPTION="A Ray Tracing Based Rendering Engine for High-Fidelity Visualization"
HOMEPAGE="http://www.ospray.org"
SRC_URI="https://github.com/ospray/ospray/archive/v${PV}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-cpp/tbb
	media-gfx/rkcommon
	!media-gfx/ospray-bin
	>=media-gfx/embree-3.9.0
	>=media-gfx/openvkl-0.11.0
"
RDEPEND="${DEPEND}"

#S="${WORKDIR}"

src_configure() {
	local mycmakeargs=(
	##-DEMBREE_ISPC_SUPPORT=OFF
	##-DEMBREE_MAX_ISA=NONE
	##-EMBREE_IGNORE_CMAKE_CXX_FLAGS=OFF
	-DOSPRAY_MODULE_DENOISER=ON
	-DOSPRAY_ENABLE_MODULES=ON
	)
	cmake-utils_src_configure
}
#src_compile() {
#	:
#}
#src_install() {
#	dodir /opt/ospray-1.8
#	cp -aR "${S}"/ospray-${PV}.x86_64.linux/* "${ED}"/opt/ospray-1.8
#}

