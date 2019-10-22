# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy ) # ???

inherit distutils-r1

DESCRIPTION="Automatic generate to Zsh Completion Function from Python’s Option Parser Modules."
HOMEPAGE="https://pypi.python.org/pypi/genzshcomp"
SRC_URI="https://pypi.python.org/packages/source/g/genzshcomp/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/pip[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
