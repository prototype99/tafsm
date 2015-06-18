# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils flag-o-matic toolchain-funcs cmake-utils git-2 versionator

DESCRIPTION="ParaViewWeb visualization aims to provide a collaborative remote web interface
for 3D visualization with ParaView as a server. Moreover, this also provide a
JavaScript API based on the ParaView scripting features and capabilities. Some
of the web samples are fully operational clients that allow you to create remote
web visualization as well as joining previously created ones with fully
interactive user interface for building complex data processing and
visualization.
"
HOMEPAGE="http://paraviewweb.kitware.com/PW/"
SRC_URI=""
EGIT_REPO_URI="http://paraview.org/ParaViewWeb.git"
#EGIT_COMMIT="pv-3.14.1"
EGIT_COMMIT="pv-3.14.1-with-superbuild"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=www-servers/tomcat-6
>=www-apache/libapreq2
 www-servers/apache
"
src_configure() {
	export HOME="${D}root"
	einfo $HOME
	mycmakeargs=(
				 -DParaView_DIR=/usr/share/paraview-3.14.1
				 -DGWT_SDK_HOME=/home/ktaki/TEST/paraviewweb/gwt-2.5.0.rc2
				 -DWORKING_DIR=/tmp/pw
				)
	cmake-utils_src_configure
}

