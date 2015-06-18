# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
#inherit distutils eutils flag-o-matic toolchain-funcs python mercurial
inherit distutils eutils flag-o-matic toolchain-funcs python
DESCRIPTION=""
HOMEPAGE="http://www.mcs.anl.gov/petsc/"
MY_PN="-p7"
LITE="-lite"
SRC_URI="http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/${PN}${LITE}-${PV}${MY_PN}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
EHG_REPO_URI="http://petsc.cs.iit.edu/petsc/releases/petsc-3.3"
DEPEND="virtual/lapack virtual/blas virtual/mpi"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P}${MY_PN}"
PETSC_DIR="${EPREFIX}/usr/share/${P}"
PETSC_ARCH="linux-gnu"
PYTHON_MODNAME=""
IUSE="python"

src_configure(){
#./configure --with-cc=gcc --with-fc=gfortran --download-f-blas-lapack --download-mpich
#econf PETSC_ARCH=${PETSC_ARCH} --doCleanup=true --with-shared-libraries=true --with-dynamic-loading=true --with-mpi
#econf PETSC_ARCH=${PETSC_ARCH} --with-shared-libraries=true --with-dynamic-loading=true --with-mpi
	econf PETSC_ARCH=${PETSC_ARCH} --with-shared-libraries --without-dynamic-loading --with-mpi --prefix=${D}${PETSC_DIR}
#--with-tetgen=
#--with-parmetis
#--with-petsc4py
#--with-numpy
#--with-scientificpython
}
src_compile(){
	emake all
}

src_install(){
	find "${PETSC_ARCH}/conf/" -type f  | while read f ; do
		elog $f
		sed -i -e "s:${D}::" ${f}
	done
	touch ${D}${PETSC_DIR}/.nagged

	emake install DESTDIR=${D}${PETSC_DIR}
#	insinto ${PETSC_DIR}
#	cd $S
#	doins -r .
	dolib.so ${PETSC_ARCH}/lib/libpetsc.so
}

