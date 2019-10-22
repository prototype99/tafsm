# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit distutils eutils flag-o-matic toolchain-funcs versionator python qt4 cmake-utils

DESCRIPTION=""
HOMEPAGE="http://itk.org/"
SRC_URI="http://sourceforge.net/projects/itk/files/itk/4.2/InsightToolkit-4.2.0.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}/InsightToolkit-${PV}"

IUSE="python"

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_EXAMPLES=OFF
	)
#if use python; then
		mycmakeargs+=(ITK_WRAP_PYTHON:BOOL=ON 
#-DITK_WRAP_DOC                    =ON
#					  -DITK_WRAP_EXPLICIT               =ON
#					  -DITK_WRAP_GCCXML                 =ON
#					  -DITK_WRAP_JAVA                   =ON
#					  -DITK_WRAP_PERL                   =ON
#					  -DITK_WRAP_RUBY                   =ON
#					  -DITK_WRAP_TCL                    =ON
#					  -DITK_WRAP_SWIGINTERFACE          =ON
					  ITK_WRAP_complex_double         :BOOL=ON
					  ITK_WRAP_complex_float          :BOOL=ON
					  ITK_WRAP_covariant_vector_double:BOOL=ON
					  ITK_WRAP_covariant_vector_float :BOOL=ON
					  ITK_WRAP_double                 :BOOL=ON
					  ITK_WRAP_float                  :BOOL=ON
					  ITK_WRAP_rgb_unsigned_char      :BOOL=ON
					  ITK_WRAP_rgb_unsigned_short     :BOOL=ON
					  ITK_WRAP_rgba_unsigned_char     :BOOL=ON
					  ITK_WRAP_rgba_unsigned_short    :BOOL=ON
					  ITK_WRAP_signed_char            :BOOL=ON
					  ITK_WRAP_signed_long            :BOOL=ON
					  ITK_WRAP_signed_short           :BOOL=ON
					  ITK_WRAP_unsigned_char          :BOOL=ON
					  ITK_WRAP_unsigned_long          :BOOL=ON
					  ITK_WRAP_unsigned_short         :BOOL=ON
					  ITK_WRAP_vector_double          :BOOL=ON
					  ITK_WRAP_vector_float           :BOOL=ON
					  )
#	else
#		mycmakeargs+=(-DITK_WRAP_PYTHON=OFF)
#			fi
			cmake-utils_src_configure
}
