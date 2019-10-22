# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
#inherit distutils eutils flag-o-matic toolchain-funcs python mercurial
inherit eutils flag-o-matic toolchain-funcs
#python
DESCRIPTION=""
HOMEPAGE="http://www.mcs.anl.gov/petsc/"
MY_PN=""
LITE="-lite"
SRC_URI="http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/${PN}${LITE}-${PV}${MY_PN}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
EHG_REPO_URI="http://petsc.cs.iit.edu/petsc/releases/petsc-3.4.4"
DEPEND="virtual/lapack"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P}${MY_PN}"
PETSC_DIR="${EPREFIX}/usr/share/${P}"
PETSC_ARCH="linux-gnu"
#PYTHON_MODNAME=""
unset PYTHON_MODNAME
IUSE="python debug"

src_configure(){
	for PY in $(find ${S}/config/ -name "*.py"); do
#elog $PY
		sed -i "s/os.unlink/pass #os.unlink/" $PY
#sed -i "s/'''Checking for MPI Datatype handles'''/return/" $PY
#sed -i "s/self.executeTest(self.configureMPIEXEC)/pass #/" $PY
#		sed -i "s/self.executeTest(self.configureMPIEXEC)/return #/" $PY
#sed -i "s/'''Checking for mpiexec'''/return/" $PY
	done
	sed -i "s/'''Checking for MPI Datatype handles'''/return #/" ${S}/config/BuildSystem/config/packages/MPI.py
	sed -i "s/self.executeTest(self.configureMPIEXEC)/return #/" ${S}/config/BuildSystem/config/packages/MPI.py
	sed -i "s/file     = os.path.join(petscdir,'.nagged'/return #/" ${S}/bin/petscnagupgrade.py
	sed -i "16i #include <string.h>" ${S}/include/petscsys.h 
	elog "${S}/include/petscsys.h"

#./configure --with-cc=gcc --with-fc=gfortran --download-f-blas-lapack --download-mpich
#econf PETSC_ARCH=${PETSC_ARCH} --doCleanup=true --with-shared-libraries=true --with-dynamic-loading=true --with-mpi
#econf PETSC_ARCH=${PETSC_ARCH} --with-shared-libraries=true --with-dynamic-loading=true --with-mpi
	if use debug ; then
		MYFLAG="${MYFLAG} --with-debugging=1"
	else
		filter-flags -O1
		filter-flags -O2
		filter-flags -O3
		append-flags -O3
		MYFLAG="${MYFLAG} --with-debugging=0 COPTFLAGS='${CFLAGS}' FOPTFLAGS='${FCFLAGS}' CXXOPTFLAGS='${CXXFLAGS}'"
	fi

	#econf PETSC_ARCH=${PETSC_ARCH} --with-shared-libraries --without-dynamic-loading --with-mpi --prefix=${D}${PETSC_DIR} ${MYFLAG}
	econf PETSC_ARCH=${PETSC_ARCH} --with-shared-libraries --with-mpi --prefix=${D}${PETSC_DIR} ${MYFLAG}
#--with-tetgen=
#--with-parmetis
#--with-petsc4py
#--with-numpy
#--with-scientificpython
}
src_compile(){
	emake -j1
}

src_install(){
	find "${PETSC_ARCH}/lib/pestc/conf/" -type f  | while read f ; do
		elog $f
		sed -i -e "s:${D}::" ${f}
	done

	emake install DESTDIR=${D}${PETSC_DIR}
	touch ${D}${PETSC_DIR}/.nagged
#	insinto ${PETSC_DIR}
#	cd $S
#	doins -r .
	dolib.so ${PETSC_ARCH}/lib/libpetsc.so
	DISTUTILS_SRC_INSTALL_EXECUTED="1"
}

