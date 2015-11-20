# Copyright (C) 2015 GENIVI Alliance
# Released under the MIT license (see COPYING.MIT for the terms)

FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://EGLWLInputEventExample.service \
    file://EGLWLMockNavigation.service \
    "

inherit systemd

FILES_${PN} += "\
    ${systemd_unitdir}/system/* \
    "

do_install_append() {
	install -d ${D}${systemd_unitdir}/system
	install -m 0444 ${WORKDIR}/EGLWLInputEventExample.service \
	                ${D}${systemd_unitdir}/system
	install -m 0444 ${WORKDIR}/EGLWLMockNavigation.service \
	                ${D}${systemd_unitdir}/system
}
