# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Create symbolic link"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/glibc"
RDEPEND="${DEPEND}"
S=${WORKDIR}
src_install() {
	dosym /lib64/ld-linux.so.2 /lib64/ld-lsb.so.3
	dosym /lib64/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3  
}
