# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic

MY_P=${P}-22
DESCRIPTION="The Matrix Template Library for C++"
HOMEPAGE="http://www.osl.iu.edu/research/mtl/"
SRC_URI="http://www.osl.iu.edu/download/research/mtl/${MY_P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE="blais lapack matlab"

DEPEND="sys-devel/gcc
	lapack? sci-libs/lapack"
RDEPEND="${DEPEND}"

WITH_LAPACK="--with-lapack=\"lapack -lblas -lg2c\""
WITH_MATLAB="--with-matlab=???"
WITH_BLAIS="--with-blais"

DESTTREE="/usr/local"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
}

src_compile() {
	cd ${S}
	local confadd=""
	if use lapack; then
		ewarn "Did not test."
		ewarn "LD_LIBRARY_PATH"
		confadd="${WITH_LAPACK} ${confadd}"
	fi
	if use matlab; then
		onfadd="${WITH_MATLAB} ${confadd}"
		ewarn "Have not tested yet."
		die
	fi
	if use blais; then
		confadd="${WITH_BLAIS} ${confadd}"
		ewarn "Have not tested yet."
		die
	fi
	econf ${confadd} --prefix=${D}/${DESTTREE} || die "econf failed"
}

src_test() {
	cd ${S}
	make tests || die "make tests failed"
	if use lapack; then
		cd ${S}/contrib/examples
		emake lapack_examples || die "econf failed"
	fi

}

src_install() {
	cd ${S}
	emake install || die "emake install failed"
}
