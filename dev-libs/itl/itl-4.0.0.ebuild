# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic base
MY_P=${P}-1

DESCRIPTION="The Iterative Template Library for C++"
HOMEPAGE="http://www.osl.iu.edu/research/itl/"
SRC_URI="http://www.osl.iu.edu/download/research/itl/${MY_P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE="mpi blitz"

DESTTREE="/usr/local"
MTLDIR="/usr/local/include"
DEPEND="dev-libs/mtl
	mpi? sys-cluster/mpich2
	blitz? dev-libs/blitz"
RDEPEND="${DEPEND}"

WITH_MPI="--with-mpi=lam"
WITH_BLITZ="--with-blitz=/usr/include"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
}

src_compile() {
	cd ${S}
	local confadd=""
	if use mpi ; then
		confadd="${WITH_MPI} ${confadd}"
	fi
	if use blitz; then
		confadd="${WITH_BLITZ} ${confadd}"
	fi
	econf ${confadd} --prefix=${D}/${DESTTREE} --with-mtl=${MTLDIR} || die "econf failed"
}

src_test() {
	make test || die "make test failed"
}

src_install() {
	cd ${S}
	emake install || die "emake install failed"
	install_include_dirs itl
}

install_include_dirs() {
	debug-print function $FUNCNAME $*
	[ -z "$1" ] && die
	local rootdir=$1
	cd ${S}/${rootdir}
	for i in `find . -maxdepth 1 -type d`
	do
		case $i in
			"CVS" | "./CVS" | "*CVS" | "*.")
				:
				;;
			".")
				:
				;;
			*)
				einfo "Making directory: $i"
				dodir ${DESTTREE}/include/${rootdir}/$i
				install_include_dirs "${rootdir}/$i"
				;;
		esac
	done
	install_include_files "${rootdir}"
}

install_include_files() {
	debug-print function $FUNCNAME $*
	[ -z "$1" ] && die
	[ -d "${S}/$1" ] || die
	cd ${S}/$1
	for i in `find . -maxdepth 1 -type f -name "*.h"`
	do
		insinto ${DESTTREE}/include/${rootdir}
		doins $i
	done
}
