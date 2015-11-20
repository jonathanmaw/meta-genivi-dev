FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = " file://client_conf.patch \
                   file://daemon_conf.patch \
                   file://am_poc.pa \
                   file://pulseaudio_user.service \
"

inherit systemd

do_install_append() {
    cp ${WORKDIR}/am_poc.pa ${D}/etc/pulse
    mkdir -p ${D}${systemd_unitdir}/system
    cp ${WORKDIR}/pulseaudio_user.service ${D}${systemd_unitdir}/system/pulseaudio.service
    mkdir -p ${D}${systemd_unitdir}/system/graphical.target.wants
    ln -sf ${systemd_unitdir}/system/pulseaudio.service ${D}${systemd_unitdir}/system/graphical.target.wants/pulseaudio.service
}

FILES_${PN}-misc += " \
                    /etc/pulse/* \
                    ${systemd_unitdir}/system/* \
                    "
