FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

DEPENDS_append = " pulseaudio"

SRC_URI_append = " file://0001-Porting-Pulse-Routing-Interface-from-AM-v1.x-to-AM-v.patch \
                   file://0001-Porting-Pulse-Control-Interface-from-AM-v1.x-to-AM-v.patch \
                   file://sqlite_database_handler_change_mainVolume_to_volume.patch \
                   file://AudioManager_user.service \
                 "
EXTRA_OECMAKE += "-DWITH_PULSE_ROUTING_PLUGIN=ON -DWITH_PULSE_CONTROL_PLUGIN=ON -DWITH_ENABLED_IPC=DBUS -DWITH_DATABASE_STORAGE=ON"

inherit systemd

do_install_append() {
    mkdir -p ${D}${systemd_unitdir}/system
    cp ${WORKDIR}/AudioManager_user.service ${D}${systemd_unitdir}/system/AudioManager.service
    mkdir -p ${D}${systemd_unitdir}/system/graphical.target.wants
    ln -sf ${systemd_unitdir}/system/AudioManager.service ${D}${systemd_unitdir}/system/graphical.target.wants/AudioManager.service
}

FILES_${PN} += "${libdir}/audioManager/control/* \
                ${libdir}/audioManager/routing/* \
                ${systemd_unitdir}/system/* \
               "
