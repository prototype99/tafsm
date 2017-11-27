# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1

DESCRIPTION="Python control for Broadlink RM2 IR controllers"
HOMEPAGE="https://github.com/mjg59/python-broadlink"
PYTHON_COMPAT=( python{2_7,3_4} pypy )
SHA="9ff6fa817b6d4314fcc9b805e480290f3a1ba20e"
SRC_URI="https://github.com/mjg59/python-broadlink/archive/${SHA}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	distutils-r1_src_install
	dosbin cli/broadlink_cli
	dosbin cli/broadlink_discovery
}
