# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Autodesk's Maya. Commercial modeling and animation package"
HOMEPAGE="http://usa.autodesk.com/maya/"
SRC_URI="http://images.autodesk.com/adsk/files/Autodesk_Maya_2016_SP6_EN_Linux_64bit.tgz"

inherit rpm eutils




LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
  media-libs/tiff:3
  app-arch/cpio
  app-arch/rpm
"
RDEPEND="${DEPEND}
 app-shells/tcsh
 dev-libs/openssl
"

src_unpack() {
	unpack ${A}
	NUM=${PV}.0-2775
	RPM="Maya${PV}_64-${NUM}.x86_64.rpm"
	#einfo ${WORKDIR}/${RPM}
	rpm2cpio ${WORKDIR}/${RPM} | cpio -idmv 
	assert "Failed to unpack ${RPM}"

	RPM="adlmapps11-11.0.15-0.x86_64.rpm"
	rpm2cpio ${WORKDIR}/${RPM} | cpio -idmv 

	RPM="adlmflexnetclient-11.0.15-0.x86_64.rpm"
	rpm2cpio ${WORKDIR}/${RPM} | cpio -idmv 
}

S="${WORKDIR}"

src_install() {
	maya=maya${PV}
	cp -pPR ./usr ./var ./opt ${D} || die

	chmod -R og+Xr ${D}/var/opt/Autodesk

	mkdir -p ${D}usr/bin/
	ln -s /usr/autodesk/${maya}/bin/${maya}  ${D}usr/bin/maya
	ln -s /usr/autodesk/${maya}/bin/Render   ${D}usr/bin/Render
	ln -s /usr/autodesk/${maya}/bin/fcheck   ${D}usr/bin/fcheck
	ln -s /usr/autodesk/${maya}/bin/imgcvt   ${D}usr/bin/imgcvt
	dosym /opt/Autodesk/Adlm/R11/lib64/libssl.so.6    /usr/lib64/libssl.so.6
	dosym /opt/Autodesk/Adlm/R11/lib64/libcrypto.so.6  /usr/lib64/libcrypto.so.6



}

pkg_postinst() {
	SERIAL_NUMBER="<YOUR SERIAL NUMBER>"
	einfo "sudo env LD_LIBRARY_PATH=/opt/Autodesk/Adlm/R11/lib64  /usr/autodesk/maya2016/bin/adlmreg -i S 657H1 657H1 2016.0.0.F ${SERIAL_NUMBER} /var/opt/Autodesk/Adlm/Maya2016/MayaConfig.pit"
}
