# Copyright (C) 2015 GENIVI Alliance
# Released under the MIT license (see COPYING.MIT for the terms)

include genivi-demo-platform-hmi.inc

SUMMARY = "Simple QML Application"
DEPENDS = "qtbase qtdeclarative"

SRC_URI_append ="\
    file://qml-example.service \
    "

SRC_URI_append_qemux86-64 ="\
    file://0004-qml_example-Make-Graphic-working-on-Qemu-machine.patch \
    "
S = "${WORKDIR}/git/app/qml-example"

inherit qmake5 systemd

do_install_append() {
	install -d ${D}${systemd_unitdir}/system
	install -m 0444 ${WORKDIR}/qml-example.service \
	                ${D}${systemd_unitdir}/system
}

FILES_${PN} += "\
    ${systemd_unitdir}/system/* \
    "
