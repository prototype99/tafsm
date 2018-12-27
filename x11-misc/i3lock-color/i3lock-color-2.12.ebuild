# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools toolchain-funcs

DESCRIPTION="Simple screen locker"
HOMEPAGE="https://github.com/PandorasFox/i3lock-color"
SRC_URI="https://github.com/PandorasFox/${PN}/archive/2.12.c.tar.gz"
MY_P="${P}.c"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	>=x11-libs/libxkbcommon-0.5.0[X]
	dev-libs/libev
	virtual/pam
	x11-libs/cairo[xcb]
	x11-libs/libxcb[xkb]
	x11-libs/xcb-util
	x11-libs/xcb-util-xrm
	!x11-misc/i3lock
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"
DOCS=( CHANGELOG README.md )

S="${WORKDIR}"/${MY_P}

src_prepare() {
	default

	echo ${PV} > I3LOCK_VERSION

	sed -i -e 's:login:system-auth:' pam/i3lock || die

	eautoreconf

	tc-export CC
}

src_install() {
	default
	doman i3lock.1
}
