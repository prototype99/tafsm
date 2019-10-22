# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ja-ipafonts/ja-ipafonts-003.03.ebuild,v 1.1 2011/05/11 22:45:31 matsuu Exp $

#inherit font

MY_P="xpdf-japanese"
DESCRIPTION="Japanese font map for xpdf"
HOMEPAGE="www.foolabs.com/xpdf/"
SRC_URI="http://mirror.ctan.org/support/xpdf/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
RDEPEND="app-text/xpdf media-fonts/ja-ipafonts"

S="${WORKDIR}/${MY_P}"
#FONT_SUFFIX="ttf"
#FONT_S="${S}"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
#
#DOCS="Readme_${MY_P}.txt"
#
## Only installs fonts
#RESTRICT="strip binchecks"
src_compile() {
	cd ${S}
	sed -i -e "s/\/usr\/local\/share/\/usr\/share/" add-to-xpdfrc
	sed -i -e "s/#display/display/" add-to-xpdfrc
	sed -i -e "s/\/usr\/....\/kochi-mincho.ttf/\/usr\/share\/fonts\/ja-ipafonts\/ipam.ttf/" add-to-xpdfrc
}
src_install() {
#	dobin xpdf || die
#	doman xpdf.1 || die
	insinto /usr/share/xpdf/japanese || die
#doins CMap || die
	doins Adobe-Japan1.cidToUnicode || die
	doins EUC-JP.unicodeMap || die
	doins ISO-2022-JP.unicodeMap || die
	doins Shift-JIS.unicodeMap || die

#insinto /usr/share/xpdf/japanese/CMap || die
	insinto /usr/share/xpdf/japanese/CMap || die
	for f in CMap/* ; do
	doins $f || die
	done
	dodoc README add-to-xpdfrc || die

	einfo "touch ~/.xpdfrc"
	einfo "bzcat /usr/share/doc/${P}/add-to-xpdfrc.bz2 >> ~/.xpdfrc"
}
