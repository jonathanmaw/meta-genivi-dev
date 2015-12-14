SUMMARY = "GENIVI AudioManager Monitor"
DESCRIPTION = "Monitor APP of the GENIVI AudioManager"

LICENSE = "MPLv2"
LIC_FILES_CHKSUM = "file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad"
DEPENDS = "qtbase qtdeclarative pulseaudio audiomanager"

BRANCH="master"

SRC_URI = "\
    git://git.projects.genivi.org/AudioManagerDemo.git;branch=${BRANCH} \
    file://AudioManager_Monitor.service \
    file://use_system_bus.patch \
    "
SRCREV = "1036480253ede59809d466a536974f9ca3cb2f61"

S = "${WORKDIR}/git"

PATCHTOOL = "git"

QMAKE_PROFILES = "${S}/"

inherit qmake5 systemd

do_install_append() {
    mkdir -p ${D}${systemd_unitdir}/system
    cp ${WORKDIR}/AudioManager_Monitor.service ${D}${systemd_unitdir}/system
}

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

FILES_${PN} += "/opt/AudioManagerMonitor/* ${systemd_unitdir}/system/*"
FILES_${PN}-dbg += "/usr/bin/AudioManagerMonitor/.debug/*"
