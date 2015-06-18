# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils latex-package
MY_P="${PN}_${PV}"
DESCRIPTION="A Preprocessor for MusiXTeX"
HOMEPAGE="http://icking-music-archive.org/software/pmx/"
SRC_URI="http://ftp.debian.org/debian/pool/main/p/pmx/${MY_P}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/p/pmx/${MY_P}-1.diff.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-tex/musixtex"
RDEPEND=""

DESTTREE="/usr"

#S=${WORKDIR}/${P}
src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${MY_P}-1.diff
}

src_compile() {
	cd ${S}
	emake PREFIX=${DESTTREE}
}

src_install() {
	cd ${S}
	emake PREFIX="${D}/${DESTTREE}" install
	cd "${S}/tex"
	insinto ${TEXMF}/tex/generic/${PN}
	doins pmx.tex || die "doins pmx.tex failed"
}
