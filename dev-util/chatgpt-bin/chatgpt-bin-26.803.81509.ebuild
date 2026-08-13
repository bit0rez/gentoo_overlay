# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="ChatGPT desktop application with Codex support"
HOMEPAGE="https://developers.openai.com/codex/app"
SRC_URI="https://persistent.oaistatic.com/codex-app-prod/linux/deb/pool/main/c/chatgpt/chatgpt_${PV}_amd64.deb -> chatgpt-${PV}.deb"
S=${WORKDIR}

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* amd64"
REQUIRED_USE="elibc_glibc"

RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libusb:1
	dev-libs/nspr
	dev-libs/nss
	dev-libs/openssl:0/3
	dev-vcs/git
	media-libs/alsa-lib
	media-gfx/graphite2
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-apps/systemd-utils
	sys-libs/glibc
	virtual/secret-service
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
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

QA_PREBUILT="usr/lib/chatgpt/.*"

src_install() {
	dodir /usr/lib
	cp -a usr/lib/chatgpt "${ED}/usr/lib/" || die

	dosym ../lib/chatgpt/codex-launcher /usr/bin/chatgpt
	domenu usr/share/applications/chatgpt.desktop
	doicon usr/share/pixmaps/chatgpt.png

	insinto /etc/apparmor.d
	doins etc/apparmor.d/chatgpt

	dodoc usr/share/doc/chatgpt/copyright
}
