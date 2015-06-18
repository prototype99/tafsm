# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit libtool flag-o-matic

MY_P=Togl-${PV}

DESCRIPTION="A Tk widget for OpenGL rendering"
HOMEPAGE="http://togl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Togl/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug +threads"

RDEPEND="
	dev-lang/tk
	virtual/opengl"
DEPEND="${RDEPEND}"

# tests directory is missing
RESTRICT="test"

S=${WORKDIR}/${MY_P}

src_prepare() {
	elibtoolize
	sed \
		-e 's:-fomit-frame-pointer::g' \
		-e 's:-O2::g' \
		-e 's:-pipe::g' \
		-i configure || die
	sed \
		 's:\$(libdir)/\$(PKG_DIR):\$(libdir):' \
		-i Makefile.in || die

}

src_configure() {
	append-ldflags -Wl,--as-needed
	econf \
		$(use_enable debug symbols) \
		$(use_enable threads) \
		--enable-shared 
}

src_compile(){
	emake DESTDIR=${D}
}
src_install() {
	emake DESTDIR=${D} PKG_DIR="" install-libraries
	emake DESTDIR=${D} install-binaries install-doc

}
