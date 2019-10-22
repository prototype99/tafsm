# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://www.ivie4.tafsm.org/~ktaki/1300_0C26.nal.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="media-gfx/sane-backends"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/sane/epjitsu/
	doins 1300_0C26.nal
}
