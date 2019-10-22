# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=3
inherit latex-package


DESCRIPTION="OTF package > UTF package"
HOMEPAGE="http://psitau.kitunebi.com/otf.html"
SRC_URI="http://www.ivie4.tafsm.org/~ktaki/otfstable.zip"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-texlive/texlive-latexrecommended
	>=dev-tex/xcolor-2.11"
DEPEND="${RDEPEND}
	app-arch/unzip"

TEXMF="/usr/share/texmf-site"
S="${WORKDIR}/otfstable"
src_compile() {
	ls .
	sed -i makeotf "s/euc/utf8/g"
	./makeotf

}
src_install() {
	echo ${TEXMF}
	insinto ${TEXMF}/tex/platex/otf/
	doins -r sty/*.sty || die

	insinto ${TEXMF}/fonts/vf/
	doins -r vf/*.vf || die

	insinto ${TEXMF}/fonts/tfm/
	doins -r tfm/*.tfm || die

	insinto ${TEXMF}/fonts/ofm/
	doins -r ofm/*.ofm || die
}

