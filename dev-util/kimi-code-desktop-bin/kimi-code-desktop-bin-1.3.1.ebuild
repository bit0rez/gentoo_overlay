# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Kimi Code Desktop coding agent (prebuilt)"
HOMEPAGE="https://www.kimi.com/code/"
SRC_URI="https://code.kimi.com/kimi-code/desktop/binaries/${PV}/KimiCode-${PV}-linux-amd64.deb -> ${P}-amd64.deb"
S=${WORKDIR}

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64"
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
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	sys-devel/gcc:*[cxx]
	>=sys-libs/glibc-2.34
	virtual/udev
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
	x11-libs/pango
	x11-misc/xdg-utils
"

# All ELF objects are upstream binaries, including the node-pty modules.
QA_PREBUILT="*"

src_install() {
	insinto /opt
	doins -r "opt/Kimi Code"
	fperms 755 "/opt/Kimi Code/kimi-code" \
		"/opt/Kimi Code/chrome_crashpad_handler" \
		"/opt/Kimi Code/chrome-sandbox"

	dosym -r "/opt/Kimi Code/kimi-code" /usr/bin/kimi-code
	domenu usr/share/applications/kimi-code.desktop
	insinto /usr/share/icons
	doins -r usr/share/icons/.
	insinto /usr/share/metainfo
	doins usr/share/metainfo/com.kimi.code.desktop.metainfo.xml

	insinto /etc/apparmor.d
	newins "opt/Kimi Code/resources/apparmor-profile" kimi-code
}
