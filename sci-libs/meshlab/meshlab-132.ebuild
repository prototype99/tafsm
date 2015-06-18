# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="MeshLab is an open source, portable, and extensible system for the
processing and editing of unstructured 3D triangular meshes. 
The system is aimed to help the processing of the typical not-so-small
unstructured models arising in 3D scanning, providing a set of tools for
editing, cleaning, healing, inspecting, rendering and converting this kind of
meshes. 
The system is heavily based on the VCG library developed at the Visual Computing
Lab of ISTI - CNR, for all the core mesh processing tasks and it is available
for Windows, MacOSX, and Linux. . The MeshLab system started in late 2005 as a
part of the FGT course of the Computer Science department of University of Pisa
and most of the code (~15k lines) of the first versions was written by a handful
of willing students. The following years FGT students have continued to work to
this project implementing more and more features. The proud MeshLab developers
are listed here. 
This project is actively supported by the 3D-CoForm project. 
Other projects that have previously supported MeshLab are listed here."
HOMEPAGE="http://meshlab.sourceforge.net/"
SRC_URI="http://sourceforge.net/projects/meshlab/files/meshlab/MeshLab%20v1.3.2/MeshLabSrc_AllInc_v132.tgz"



LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/meshlab/src"

src_compile(){
#elog $S
	cd external
	eqmake4 -recursive external.pro
	emake

#	pwd
#	elog $S
#	pwd
	cd ${S}
	pwd
#	elog "equmake: ${PWD}"
	qmake -recursive meshlab_full.pro 
	emake
}
src_install(){
	mkdir bin
	cd bin
	touch meshlab
	chmod 644 meshlab
	echo "#!/bin/sh" >> meshlab
	echo "/usr/share/${PN}/meshlab" >> meshlab
	dobin meshlab

	touch meshlabserver
	chmod 644 meshlabserver
	echo "#!/bin/sh" >> meshlabserver
	echo "/usr/share/${PN}/meshlabserver" >> meshlabserver
	dobin meshlabserver
	cd ${S}

	cd distrib


	dolib.so libcommon.so
	dolib.so libcommon.so.1
	dolib.so libcommon.so.1.0
	dolib.so libcommon.so.1.0.0
	dodir /usr/share/"${PN}"
	cp	meshlab "${ED}"/usr/share/${PN} 
	cp	meshlabserver "${ED}"/usr/share/${PN} 
	cp -PR plugins/  render_template/  sample/  shaders/  textures/ "${ED}"/usr/share/${PN} 
}
