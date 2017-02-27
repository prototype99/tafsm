# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Read, modify and write DICOM files with python code"
HOMEPAGE="http://code.google.com/p/pydicom/"
#SRC_URI="http://pydicom.googlecode.com/files/${P}.tar.gz"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

#src_install() {
#	distutils_src_install
#}
