# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit versionator flag-o-matic

DESCRIPTION="
SLEPc the Scalable Library for Eigenvalue Problem Computations, is a software
library for the solution of large sparse eigenproblems on parallel computers. It
can be used for the solution of problems formulated in either standard or
generalized form, as well as other related problems such as the singular value
decomposition or the quadratic eigenvalue problem.
"
HOMEPAGE="http://www.grycap.upv.es/slepc/"
MY_PN="-p2"
SRC_URI="http://www.grycap.upv.es/slepc/download/download.php?filename=${P}${MY_PN}.tar.gz"


LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="debug"
S="${WORKDIR}/${P}${MY_PN}"

DEPEND="sci-libs/petsc"
RDEPEND="${DEPEND}"


#PETSC_ARCH="linux-gnu"
PETSC_ARCH="arch-installed-petsc"
src_configure(){
	elog "src_configure start"
	local v=$(best_version sci-libs/petsc)
	v=${v#sci-libs/}
	v=$(get_version_component_range 1-3 $v)
	PETSC_DIR="${EPREFIX}/usr/share/$v"
	elog PETSC_DIR=${PETSC_DIR}
#elog PETSC_ARCH=${PETSC_ARCH}
	export PETSC_DIR
#	export PETSC_ARCH

#econf PETSC_ARCH=${PETSC_ARCH} PETSC_DIR=${PETSC_DIR}
	export SLEPC_DIR=${S}
#	if use debug ; then
#		MYFLAG="${MYFLAG} --with-debugging=1"
#	else
#		filter-flags -O1
#		filter-flags -O2
#		filter-flags -O3
#		append-flags -O3
#		MYFLAG="${MYFLAG} --with-debugging=0 COPTFLAGS='${CFLAGS}' FOPTFLAGS='${FCFLAGS}' CXXOPTFLAGS='${CXXFLAGS}'"
#	fi

	./configure ${MYFLAG}
	elog "src_configure end"
}

src_compile(){
	elog "src_compile start"
	emake SLEPC_DIR=${S} PETSC_DIR=${PETSC_DIR} PETSC_ARCH=${PETSC_ARCH}
	elog "src_compile end"
}
src_install(){
	emake SLEPC_DIR=${S} PETSC_DIR=${PETSC_DIR} PETSC_ARCH=${PETSC_ARCH} SLEPC_DESTDIR=${D}/usr/share/${P} install
	dolib arch-installed-petsc/lib/*
}
