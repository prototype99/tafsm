# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4} pypy )

inherit distutils-r1

DESCRIPTION="A cross-platform clipboard module for Python."

HOMEPAGE="https://github.com/asweigart/pyperclip"
#SRC_URI="http://pypi.python.org/pypi/pybtex"
SHA="7deec0b6464bbda18ce2f700980edba2d6c51e10"
SRC_URI="https://github.com/asweigart/pyperclip/archive/${SHA}.zip"
#https://pypi.python.org/packages/7b/a5/48eaa1f2d77f900679e9759d2c9ab44895e66e9612f7f6b5333273b68f29/pyperclip-1.5.27.zip#md5=18b86c2e6d10ed827cdd42aed80b4cbe

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"


RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	x11-misc/xclip
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}-${SHA}"

#python_compile_all() {
#	use doc && emake -C doc html
#}

