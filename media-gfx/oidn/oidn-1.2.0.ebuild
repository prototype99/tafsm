# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils multilib cmake-utils
DESCRIPTION="Open Image Denoise is an open source library of high-performance,
high-quality denoising filters for images rendered with ray tracing."
HOMEPAGE="https://openimagedenoise.github.io"
SRC_URI="https://github.com/OpenImageDenoise/oidn/releases/download/v${PV}/${P}.src.tar.gz"

LICENSE="Apache 2.0 license"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-cpp/tbb
	>=dev-lang/ispc-bin-1.12.0
"
RDEPEND="${DEPEND}"

src_configure() {
	#OIDN_STATIC_LIB
	local mycmakeargs=(
	#-DEMBREE_ISPC_SUPPORT=OFF
	-DOIDN_APPS:BOOL=OFF
	)
	cmake-utils_src_configure
}
#src_install() {
#:
#}
