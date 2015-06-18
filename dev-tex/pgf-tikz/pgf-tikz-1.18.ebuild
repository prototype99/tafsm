# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package

DESTTREE="/usr/local/"

DESCRIPTION="PGF and TikZ -- Graphic systems for TeX"
HOMEPAGE="http://sourceorge.net/projects/pgf"
MY_P="pgf-1.18"
SRC_URI="mirror://sourceforge/pgf/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=app-text/tetex-3.0"

S=${WORKDIR}/${MY_P}
SUPPLIER="public"

src_install() {
	insinto /usr/share/texmf/tex/
	for dir in generic latex plain ; do
		doins -r ${dir} || die "Failed installing"
	done
	ewarn "pgf/*.sty have to remove."
	dodir /usr/share/doc/${PF}
	insinto /usr/share/doc/${PF}
	doins -r doc/generic/pgf/* || die "Failed doc"
}
