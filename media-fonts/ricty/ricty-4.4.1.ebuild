# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font


MY_PN="Ricty"
MY_PA1="Inconsolata"
MY_PA2="migu-1m-20150712"
DESCRIPTION="A beautiful sans-serif monotype Japanese font designed for code listings"
HOMEPAGE="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html"
#SRC_URI="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty/${MY_PN}-${PV}.tar.gz"
# SRC_URI="https://github.com/yascentur/${MY_PN}/tarball/${PV} -> ${MY_PN}-${PV}.tar.gz"

# https://github.com/google/fonts/raw/master/ofl/inconsolata/${MY_PA1}-Bold.ttf
# https://github.com/google/fonts/raw/master/ofl/inconsolata/${MY_PA1}-Regular.ttf

SRC_URI="http://www.rs.tus.ac.jp/yyusa/${PN}/${PN}_generator.sh
https://osdn.jp/projects/mix-mplus-ipa/downloads/63545/${MY_PA2}.zip
"

LICENSE="OFL-1.1 IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="
	media-gfx/fontforge"
RDEPEND=""

S="${WORKDIR}"
src_unpack() {
		cp "${DISTDIR}"/${PN}_generator.sh "${S}"/${PN}_generator.sh
		wget https://github.com/google/fonts/raw/master/ofl/inconsolata/${MY_PA1}-Regular.ttf 
		wget https://github.com/google/fonts/raw/master/ofl/inconsolata/${MY_PA1}-Bold.ttf 
		cp ${MY_PA1}-Regular.ttf ${S}
		cp ${MY_PA1}-Bold.ttf ${S}
		unpack  ${MY_PA2}.zip
		cp ${MY_PA2}/migu-1m-regular.ttf "${S}"/migu-1m-regular.ttf
		cp ${MY_PA2}/migu-1m-bold.ttf "${S}"/migu-1m-bold.ttf
}

#S="${WORKDIR}/yascentur-${MY_PN}-*"

FONT_SUFFIX="ttf"
FONT_S="${S}"

# Only installs fonts.
RESTRICT="strip binchecks"

src_compile() {
	# sh ${PN}_generator.sh  auto
	# 	Inconsolata-{Regular,Bold}.ttf migu-1m-{regular,bold}.ttf||die
	sh ${PN}_generator.sh  \
		Inconsolata-{Regular,Bold}.ttf migu-1m-{regular,bold}.ttf||die
}
