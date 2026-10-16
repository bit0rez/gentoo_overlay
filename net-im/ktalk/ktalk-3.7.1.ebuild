# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Kontur.Talk (KTalk) video conferencing desktop application"
HOMEPAGE="https://ktalk.ru/"
SRC_URI="https://st.ktalk.host/ktalk-app/linux/ktalk${PV}amd64.deb"
S=${WORKDIR}

# The product and bundled NDI runtime are distributed under proprietary terms.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64"
IUSE="suid"
REQUIRED_USE="elibc_glibc"

RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/libpng:0/16
	media-libs/mesa
	net-dns/avahi[dbus]
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	>=sys-libs/glibc-2.25
	sys-devel/gcc:*[cxx]
	virtual/libudev
	virtual/zlib
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="opt/ktalk/*"
REQUIRES_EXCLUDE="opt/ktalk/resources/app.asar.unpacked/node_modules/ktalk-robotjs/prebuilds/linux-arm64/*"

src_prepare() {
	default

	sed -i 's#^Exec=.*#Exec=ktalk %U#' \
		usr/share/applications/ktalk.desktop || die
	sed -i 's#/opt/Толк/ktalk#/opt/ktalk/ktalk#g' \
		opt/Толк/resources/apparmor-profile || die
}

src_install() {
	dodir /opt
	cp -a opt/Толк "${ED}/opt/ktalk" || die
	use suid && fperms u+s /opt/ktalk/chrome-sandbox

	dosym -r /opt/ktalk/ktalk /usr/bin/ktalk
	domenu usr/share/applications/ktalk.desktop
	doicon -s 512 usr/share/icons/hicolor/512x512/apps/ktalk.png

	insinto /etc/apparmor.d
	newins opt/Толк/resources/apparmor-profile ktalk

	dodoc usr/share/doc/ktalk/changelog.gz
}
