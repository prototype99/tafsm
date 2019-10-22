# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION=""
HOMEPAGE="http://www.adobe.com/devnet/flex.html"
SRC_URI="http://download.macromedia.com/pub/flex/sdk/flex_sdk_4.6.zip"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

FLEX_SDK_DIR="opt/${PN}"

src_configure() {
	    :
}

src_compile() {
	    :
}

src_install() {
	dodir "/${FLEX_SDK_DIR}"
	cp -pPR * "${ED}/${FLEX_SDK_DIR}"
}

