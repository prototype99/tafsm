# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit distutils eutils flag-o-matic toolchain-funcs python cmake-utils subversion qt4

DESCRIPTION="Slicer, or 3D Slicer, is a free, open source software package for
visualization and image analysis. 3D Slicer is natively designed to be available
on multiple platforms, including Windows, Linux and Mac Os X."
HOMEPAGE="http://www.slicer.org/slicerWiki/index.php/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	<x11-libs/qt-core-4.8
	<x11-libs/qt-webkit-4.8
	<x11-libs/qt-gui-4.8
	<x11-libs/qt-test-4.8
"
RDEPEND="${DEPEND}"

ESVN_REPO_URI="http://svn.slicer.org/Slicer4/trunk"
#ESVN_OPTIONS="-s"
ESVN_REVISION="${PV}"

