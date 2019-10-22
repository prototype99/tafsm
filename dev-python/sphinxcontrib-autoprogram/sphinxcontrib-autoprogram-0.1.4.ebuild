# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1

DESCRIPTION="This contrib extension, sphinxcontrib.autoprogram, provides an automated way to document CLI programs. It scans argparse.ArgumentParser object, and then expands it into a set of .. program:: and .. option:: directives."
HOMEPAGE="https://pythonhosted.org/sphinxcontrib-autoprogram/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc test"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/namespace-sphinxcontrib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_compile_all() {
	if use doc; then
		python_setup
		esetup.py build_sphinx
		HTML_DOCS=( "${BUILD_DIR}/sphinx/html/." )
	fi
}

python_test() {
	esetup.py pytest || die
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
