# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit distutils

DESCRIPTION="A Python interface to the HDF5 library"
HOMEPAGE="http://code.google.com/p/h5py/"
SRC_URI="http://h5py.googlecode.com/files/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=">=sci-libs/hdf5-1.6.5
	>=dev-lang/python-2.5
	>=dev-python/numpy-1.0.3"
DEPEND="${RDEPEND}"

src_compile() {
	distutils_python_version
	"${python}" setup.py build
}

