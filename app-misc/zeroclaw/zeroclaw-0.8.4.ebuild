# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Fast, lightweight, and fully autonomous AI assistant"
HOMEPAGE="https://zeroclawlabs.ai https://github.com/zeroclaw-labs/zeroclaw"
SRC_URI="
	amd64? (
		elibc_glibc? (
			https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${PV}/zeroclaw-x86_64-unknown-linux-gnu.tar.gz
			desktop? (
				https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${PV}/ZeroClaw-linux-amd64.deb
					-> ${P}-desktop-amd64.deb
			)
		)
		elibc_musl? (
			https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${PV}/zeroclaw-x86_64-unknown-linux-musl.tar.gz
		)
	)
	arm64? (
		elibc_glibc? (
			https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${PV}/zeroclaw-aarch64-unknown-linux-gnu.tar.gz
		)
		elibc_musl? (
			https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${PV}/zeroclaw-aarch64-unknown-linux-musl.tar.gz
		)
	)
"

S=${WORKDIR}

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="-* amd64 arm64"
IUSE="desktop"
REQUIRED_USE="
	^^ ( elibc_glibc elibc_musl )
	desktop? ( amd64 elibc_glibc )
"

RESTRICT="strip"

RDEPEND="
	elibc_glibc? (
		>=sys-libs/glibc-2.34
		sys-devel/gcc:*[cxx]
	)
	desktop? (
		dev-libs/libayatana-appindicator
		net-libs/webkit-gtk:4.1
		sys-apps/dbus
		x11-libs/gtk+:3
	)
"

QA_PREBUILT="
	usr/bin/zeroclaw
	usr/bin/zerocode
	usr/bin/zeroclaw-desktop
"

src_install() {
	dobin zeroclaw zerocode

	insinto /usr/share/zeroclawlabs
	doins -r web

	if use desktop; then
		dobin usr/bin/zeroclaw-desktop
		domenu usr/share/applications/ZeroClaw.desktop
		doicon -s 32 usr/share/icons/hicolor/32x32/apps/zeroclaw-desktop.png
		doicon -s 128 usr/share/icons/hicolor/128x128/apps/zeroclaw-desktop.png
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	einfo "Run 'zeroclaw quickstart' to configure your first agent."
	use desktop && einfo "Launch ZeroClaw Desktop from the application menu or run 'zeroclaw-desktop'."
	einfo "Use Portage to update ZeroClaw; the built-in updater cannot replace"
	einfo "system-managed files under ${EPREFIX}/usr."
}
