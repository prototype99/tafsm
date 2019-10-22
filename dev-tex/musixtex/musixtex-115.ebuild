# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs latex-package
#toolchain-funcs : tc-getCC
#latex-package : TEXMF

MY_P="${PN}-${PV}"
DESTTREE="/usr/local/"

DESCRIPTION="MusiX TeX"
HOMEPAGE="http://icking-music-archive.org/software/indexmt6.html"

SRC_URI="http://icking-music-archive.org/software/musixtex/musixtex.zip"

LICENSE="musixtex"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

#DEPEND="app-text/ptex"
#RDEPEND=""

S=${WORKDIR}/${MY_P}
SUPPLIER="public"

#src_unpack() {
#	unpack ${MY_P}.tar.gz
#}

#src_compile() {
#	cd ${S}/system/c-source
#	$(tc-getCC) ${CFLAGS} -o musixflx musixflx.c || die
#	echo "|${TEXMF}/tex/generic/musixtex|"
#	echo "|${TEXMF}/fonts/sources/public/musixtex|"
#	echo "|${TEXMF}/tfm/public/musixtex|"
#}

#src_install() {
#	cd "${S}/system/c-source"
#	dobin musixflx || die "doins musixflx failed"
#	cd "${S}/doc"
#	latex-package_src_install
#	cd "${S}/mf"
#	dodir ${TEXMF}/fonts/source/${SUPPLIER}/${PN}
#	for i in `find . -maxdepth 1 -type f -name "*.mf"`
#	do
#		insinto ${TEXMF}/fonts/source/${SUPPLIER}/${PN}
#		doins $i || die "doins $i failed"
#	done
#	cd "${S}/tfm"
#	latex-package_src_install
#
#	cd "${S}/tex"
#	for i in `find . -maxdepth 1 -type f -name "*.sty"`
#	do
#		insinto ${TEXMF}/tex/generic/${PN}
#		doins $i || die "doins $i failed"
#	done
#	for i in `find . -maxdepth 1 -type f -name "*.tex"`
#	do
#		insinto ${TEXMF}/tex/generic/${PN}
#		doins $i || die "doins $i failed"
#	done
#
#}
