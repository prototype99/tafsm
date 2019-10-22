# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Fixup for open vmware tools"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="=app-emulation/open-vm-tools-2012.12.26.958366"
RDEPEND="${DEPEND}"
S="${D}"
src_install(){
	dosbin ${FILESDIR}/ifup
	dosbin ${FILESDIR}/ifdown
	dosym /etc/init.d/dhcpd /etc/init.d/network
}
