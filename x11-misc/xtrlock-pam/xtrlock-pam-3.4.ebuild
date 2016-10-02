# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit git-r3

DESCRIPTION=""
HOMEPAGE="http://aanatoly.github.io/xtrlock-pam"
EGIT_REPO_URI="https://github.com/aanatoly/xtrlock-pam"
EGIT_TAG="3.4"
#SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


RDEPEND="
	x11-libs/libX11
"
DEPEND="
	${RDEPEND}
	x11-proto/xproto
	x11-misc/imake
"


