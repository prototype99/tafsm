# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod

DESCRIPTION=""
HOMEPAGE="http://www.basyskom.org/~eva/log_installation_vaio_z21vnx.html"
SRC_URI="http://www.basyskom.org/~eva/sony-laptop-zseries-0.9.tar.bz2"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

MODULE_NAMES="sony-laptop(kernel/drivers/platform/x86:${S})"
pkg_setup() {
	# We have to put this to the global scope inside the function or it will be
	# reset between functions because the ebuild is sourced many times.

	linux-mod_pkg_setup
}
src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:default:module:" "${S}/Makefile"
	sed -i -r -e 's/define SONY_LAPTOP_DRIVER_VERSION\s+"0.6"/define SONY_LAPTOP_DRIVER_VERSION	"0.9"/' "${S}/sony-laptop.c"
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	einfo "INSTALL: ${MODULE_NAMES}"
	linux-mod_src_install
	dodoc README 
}
pkg_postinst() {
	einfo "postinst"
	linux-mod_pkg_postinst
}

