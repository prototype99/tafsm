# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://ftp.jaist.ac.jp/pub/apache/activemq/apache-activemq/5.6.0/activemq-parent-5.6.0-source-release.zip"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-java/maven-bin"

RDEPEND=""

S="work/"

src_install(){
	insinto "${EPREFIX}/usr/share/${P}/"
	doins activemq-parent-${PV}
}
