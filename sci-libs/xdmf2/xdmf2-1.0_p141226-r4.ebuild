# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 python3_7 )

inherit cmake-utils flag-o-matic python-single-r1

DESCRIPTION="eXtensible Data Model and Format"
HOMEPAGE="http://xdmf.org/index.php/Main_Page"
SRC_URI="https://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

SLOT="0"
LICENSE="VTK"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE="doc python test"
RESTRICT="!test? ( test )"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	dev-libs/boost:=
	sci-libs/hdf5:=
	dev-libs/libxml2:2
	python? ( ${PYTHON_DEPS} )
	"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	python? ( dev-lang/swig:0 )
"

PATCHES=(
	"${FILESDIR}"/${P}-module.patch
	"${FILESDIR}"/${P}-cannot-find-hdf5-bug-591302.patch
	"${FILESDIR}"/${P}-cmake-3.12.patch
	"${FILESDIR}"/${P}-mpi4py.patch
	"${FILESDIR}"/${P}-libpath.patch
)

pkg_setup() {
	use python && python-single-r1_pkg_setup && python_export
}

src_prepare() {
	#eapply -p2 "${FILESDIR}"/${P}-lib.patch
	#eapply -p2 "${FILESDIR}"/${P}-swig.patch

	cmake-utils_src_prepare
}

src_configure() {
	# bug 619604
	append-cxxflags -std=c++14

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=1
		-DXDMF_BUILD_DOCUMENTATION=$(usex doc)
		-DBUILD_TESTING=$(usex test)
		-DXDMF_WRAP_PYTHON=$(usex python)
#		-DXDMF_WRAP_JAVA=$(usex java)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dosym XdmfConfig.cmake /usr/share/cmake/Modules/${PN}Config.cmake

	# need to byte-compile 'XdmfCore.py' and 'Xdmf.py'
	# as the CMake build system does not compile them itself
	use python && python_optimize "${D%/}$(python_get_sitedir)"
}
