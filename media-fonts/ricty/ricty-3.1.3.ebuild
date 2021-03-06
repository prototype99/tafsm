# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ricty/ricty-3.2.0.ebuild,v 1.1 2012/06/23 22:36:53 matsuu Exp $

EAPI=5
inherit font

MY_PN="Ricty"
GITHUB_NAME="kudryavka"
DESCRIPTION="A beautiful sans-serif monotype Japanese font designed for code listings"
HOMEPAGE="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html"
#SRC_URI="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty/${MY_PN}-${PV}.tar.gz"
SRC_URI="https://github.com/${GITHUB_NAME}/${MY_PN}/archives/${PV} -> ${MY_PN}-${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-fonts/inconsolata-20140821
	>=media-fonts/mix-mplus-ipa-2011100
	media-gfx/fontforge"
RDEPEND=""

#S="${WORKDIR}/yascentur-${MY_PN}-*"
S="${WORKDIR}/${GITHUB_NAME}-${MY_PN}-fe68161"

FONT_SUFFIX="ttf"
FONT_S="${S}"

# Only installs fonts.
RESTRICT="strip binchecks"

src_compile() {
	sh ricty_generator.sh -z \
		"${EPREFIX}/usr/share/fonts/inconsolata/Inconsolata-Regular.ttf" \
		"${EPREFIX}/usr/share/fonts/mix-mplus-ipa/migu-1m-regular.ttf" \
		"${EPREFIX}/usr/share/fonts/mix-mplus-ipa/migu-1m-bold.ttf" || die
}
