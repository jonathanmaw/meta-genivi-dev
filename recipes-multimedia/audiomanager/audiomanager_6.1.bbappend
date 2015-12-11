FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

DEPENDS_append = " pulseaudio"

SRC_URI_append = " file://0001-Porting-Pulse-Routing-Interface-from-AM-v1.x-to-AM-v.patch \
                   file://0001-Porting-Pulse-Control-Interface-from-AM-v1.x-to-AM-v.patch \
                   file://sqlite_database_handler_change_mainVolume_to_volume.patch \
                   file://AudioManager.service \
                   file://org.genivi.audiomanager.conf \
                   file://org.genivi.audiomanager.service \
                 "
EXTRA_OECMAKE += "-DWITH_PULSE_ROUTING_PLUGIN=ON -DWITH_PULSE_CONTROL_PLUGIN=ON -DWITH_ENABLED_IPC=DBUS -DWITH_DATABASE_STORAGE=ON"

inherit systemd

do_install_append() {
    mkdir -p ${D}${systemd_unitdir}/system
    cp ${WORKDIR}/AudioManager.service ${D}${systemd_unitdir}/system/AudioManager.service
    mkdir -p ${D}${systemd_unitdir}/system/graphical.target.wants
    ln -sf ${systemd_unitdir}/system/AudioManager.service ${D}${systemd_unitdir}/system/graphical.target.wants/AudioManager.service
    mkdir -p ${D}/etc/dbus-1/system.d
    cp ${WORKDIR}/org.genivi.audiomanager.conf ${D}/etc/dbus-1/system.d
    mkdir -p ${D}/usr/share/dbus-1/system-services
    cp ${WORKDIR}/org.genivi.audiomanager.service ${D}/usr/share/dbus-1/system-services
}

FILES_${PN} += "${libdir}/audioManager/control/* \
                ${libdir}/audioManager/routing/* \
                ${systemd_unitdir}/system/* \
                /etc/dbus-1/system.d/* \
                /usr/share/dbus-1/system-services/* \
               "
