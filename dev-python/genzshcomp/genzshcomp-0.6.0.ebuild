# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
PYTHON_COMPAT=( python3_6 python3_7 python3_8 ) # ???

inherit distutils-r1

DESCRIPTION="Automatic generate to Zsh Completion Function from Python’s Option Parser Modules."
HOMEPAGE="https://pypi.python.org/pypi/genzshcomp"
#SRC_URI="https://pypi.python.org/packages/source/g/genzshcomp/${P}.tar.gz"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#DEPEND="dev-python/pip[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
DEPEND="${RDEPEND}"
