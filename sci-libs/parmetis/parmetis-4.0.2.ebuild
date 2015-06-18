# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/parmetis/parmetis-3.2.0.ebuild,v 1.3 2012/08/03 22:20:54 bicatali Exp $

EAPI=4
inherit eutils autotools

#MYP=ParMetis-${PV}

DESCRIPTION="Parallel graph partitioner"
HOMEPAGE="http://www-users.cs.umn.edu/~karypis/metis/parmetis/"
SRC_URI="http://glaros.dtc.umn.edu/gkhome/fetch/sw/${PN}/${PN}-${PV}.tar.gz"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="free-noncomm"
SLOT="0"
IUSE="doc static-libs"

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}
	!sci-libs/metis"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
##sed -i -e "s/#define IDXTYPEWIDTH 32/#define IDXTYPEWIDTH 64/" metis/include/metis.h || die
sed -i -e "s/#define REALTYPEWIDTH 32/#define REALTYPEWIDTH 64/" metis/include/metis.h || die
}

src_configure() {
#econf $(use_enable static-libs static)
	cd metis
	DEBUG=
#DEBUG="debug=1 gdb=1 assert=1 assert2=1"
	emake config prefix=${D}usr ${DEBUG}
	cd ..
	emake config prefix=${D}usr ${DEBUG}
}
src_compile() {
	emake 
}

src_install() {
	cd metis
	emake install
	cd ..
	emake install
#default
	use doc && dodoc Manual/*.pdf
}
