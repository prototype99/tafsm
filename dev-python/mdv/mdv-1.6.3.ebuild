# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1
#inherit python-single-r1

DESCRIPTION="Terminal Markdown Viewerm"
HOMEPAGE="https://github.com/axiros/terminal_markdown_viewer"
SRC_URI="https://github.com/axiros/terminal_markdown_viewer/archive/${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/terminal_markdown_viewer-${PV}"
DEPEND="
dev-python/pyyaml[${PYTHON_USEDEP}]
dev-python/pygments[${PYTHON_USEDEP}]
dev-python/markdown[${PYTHON_USEDEP}]
dev-python/docopt[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

#pkg_setup() {
#	python-single-r1_pkg_setup
#}
