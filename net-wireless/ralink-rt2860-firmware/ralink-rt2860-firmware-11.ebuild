# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit eutils

DESCRIPTION="RT2860 Firmware"
HOMEPAGE="http://www.ralinktech.com/"
SRC_URI="http://www.ralinktech.com.tw/data/drivers/RT2860_Firmware_V11.zip"

LICENSE=""
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND="app-arch/zip"
RDEPEND="net-wireless/ralink-rt2860"
S=${WORKDIR}

src_unpack(){
	unzip -jqqo "${DISTDIR}/${A}" || ewarn "This is becuase of an upstream bug."
}
src_install() {
	insinto /lib/firmware
	doins rt2860.bin
}

