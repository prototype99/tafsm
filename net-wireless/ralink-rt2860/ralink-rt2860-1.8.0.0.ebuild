# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-mod

DESCRIPTION="Driver for the RaLink RT2860  wireless chipset"
HOMEPAGE="http://www.ralinktech.com/"
LICENSE="GPL-2"

#MY_P=${P/${PN}-/IS_Linux_STA_6x_D_}
MY_P=2008_0918_RT2860_Linux_STA_v1.8.0.0

SRC_URI="http://www.ralinktech.com.tw/data/drivers/2008_0918_RT2860_Linux_STA_v1.8.0.0.tar.bz2"

KEYWORDS="-* amd64 x86"
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND="net-wireless/wireless-tools
	net-wireless/wpa_supplicant"

S="${WORKDIR}/${MY_P}"

MODULE_NAMES="rt61(net:${S}/Module)"
BUILD_TARGETS=" "
MODULESD_RT61_ALIASES=('ra? rt61')

CONFIG_CHECK="WIRELESS_EXT"
ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_WIRELESS_EXT)."

src_compile() {
epatch ${FILESDIR}/2008_0918_RT2860_Linux_STA_v1.8.0.0.patch
epatch ${FILESDIR}/2008_0918_RT2860_Linux_STA_v1.8.0.0_conf.patch
#	if kernel_is 2 6; then
#		cp Module/Makefile.6 Module/Makefile
#	elif kernel_is 2 4; then
#		cp Module/Makefile.4 Module/Makefile
#	else
#		die "Your kernel version is not supported!"
#	fi
#MODE=APSTA
#RT28xx_MODE=APSTA
	MY_CONF=
#MY_CONF="${MY_CONF} RT28xx_MODE=APSTA"
	CHIPSET="2860"
	MY_CONF="${MY_CONF} TARGET=LINUX"
	MY_CONF="${MY_CONF} CHIPSET=${CHIPSET}"
	MY_CONF="${MY_CONF} LINUX_SRC=/usr/src/linux"
	MY_CONF="${MY_CONF} HAS_WPA_SUPPLICANT=y"
	MY_CONF="${MY_CONF} HAS_NATIVE_WPA_SUPPLICANT_SUPPORT=y"
	MY_CONF="${MY_CONF} HAS_ATE=y"
	MY_CONF="${MY_CONF} HAS_28xx_QA=y"
#MY_CONF="${MY_CONF} ARCH=x86_64"
#MY_CONF="${MY_CONF} ARCH=$(uname -m)"
	MY_CONF="${MY_CONF} ARCH=x86"
	make ${MY_CONF} || die "make failed" 
#	linux-mod_src_compile
}

src_install() {
#linux-mod_src_install
	CHIPSET="2860"
	DATA_PATH=/etc/Wireless/RT${CHIPSET}STA
	DATA_FILE_NAME=RT${CHIPSET}STA.dat
	MOD_NAME=rt${CHIPSET}sta
	insinto ${DATA_PATH}
	insopts -m 0600
	doins ${DATA_FILE_NAME}

	insinto /lib/modules/$(uname -r)/kernel/drivers/net/wireless/
	insopts -m 0644
	doins "os/linux/${MOD_NAME}.ko"
	dodoc  README_STA  iwpriv_usage.txt
}
