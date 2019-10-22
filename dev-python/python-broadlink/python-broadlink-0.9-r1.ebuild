# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 
#inherit python-single-r1

#inherit distutils-r1 python-single-r1
#inherit  python-single-r1

DESCRIPTION="Python control for Broadlink RM2 IR controllers"
HOMEPAGE="https://github.com/mjg59/python-broadlink"
SHA="1cceae73eb4f936283c6eaf9eed99f365a37d467"
SRC_URI="https://github.com/mjg59/python-broadlink/archive/${SHA}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/pyaes[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	distutils-r1_src_install
	dosbin cli/broadlink_cli
	dosbin cli/broadlink_discovery
}
