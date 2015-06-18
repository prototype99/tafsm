# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils fortran-2 toolchain-funcs versionator cmake-utils

MY_P="${PN}_$(replace_version_separator 2 '.')"
#MY_S="${PN}_$(get_version_component_range 1-2)"

DESCRIPTION="The CFD General Notation System (CGNS) is a standard for CFD data"
HOMEPAGE="http://www.cgns.org/"
SRC_URI="mirror://sourceforge/cgns/${MY_P}-4.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="fortran hdf5 szip zlib python"

DEPEND="
	fortran? ( virtual/fortran )
	hdf5? ( >=sci-libs/hdf5-1.8 )
	szip? ( sci-libs/szip )
	zlib? ( sys-libs/zlib )
	!sci-libs/cgnstools"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

pkg_setup() {
	use fortran && fortran-2_pkg_setup
}
src_configure() {
	mycmakeargs=(
		-DCG_BUILD_SCOPE:BOOL=OFF
		-DCGNS_BUILD_SHARED:BOOL=ON
		-DENABLE_SCOPING:BOOL=ON
		-DBUILD_CGNSTOOLS:BOOL=ON
		-DENABLE_FORTRAN:BOOL=OFF
		-DENABLE_HDF5:BOOL=ON
		-DENABLE_LEGACY:BOOL=ON
				 )
#if use python; then
#//Enable or disable scoping of enumeration values
#mycmakeargs+=(ENABLE_SCOPING:BOOL=ON)

#//Build the CGNSTools package
#			mycmakeargs+=(BUILD_CGNSTOOLS:BOOL=ON)

#//Build a shared version of the library
#	fi
#	if use fortran; then
#//Enable or disable the use of Fortran
#mycmakeargs+=(ENABLE_FORTRAN:BOOL=ON)
#	fi
#	if use hdf5; then
#//Enable or disable HDF5 interface
#mycmakeargs+=(ENABLE_HDF5:BOOL=ON)
#	fi
#mycmakeargs+=(ENABLE_LEGACY:BOOL=ON)
#einfo $mycmakeargs
	cmake-utils_src_configure
	cmake-utils_src_configure
}


#src_prepare() {
#	epatch "${FILESDIR}"/${P}.patch
#	use hdf5 && epatch "${FILESDIR}"/${P}_hdf5.patch
#}

#src_configure() {
#	local myconf="--enable-gcc --enable-lfs --enable-shared=all --enable-64bit"
#
#	tc-export CC FC
#
#	econf \
#		${myconf} \
#		$(use_with fortran) \
#		$(use_with hdf5) \
#		$(use_with zlib) \
#		$(use_with szip)
#}
#
#src_install() {
#	emake DESTDIR="${D}" install
#	use hdf5 && \
#		fperms 755 /usr/bin/{hdf2adf,adf2hdf} || \
#		rm -f "${D}"/usr/bin/{hdf2adf,adf2hdf}
#}
