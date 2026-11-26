# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Unofficial Yandex Music client written in Rust and Slint"
HOMEPAGE="https://github.com/SpolzerMod/yamusic-rs"
SRC_URI="
	amd64? (
		https://github.com/SpolzerMod/yamusic-rs/releases/download/v${PV}/yamusic-rs_${PV}-1_amd64.deb
	)
	arm64? (
		https://github.com/SpolzerMod/yamusic-rs/releases/download/v${PV}/yamusic-rs_${PV}-1_arm64.deb
	)
"
S=${WORKDIR}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* amd64 arm64"
REQUIRED_USE="elibc_glibc"
RESTRICT="strip"

RDEPEND="
	app-misc/ca-certificates
	dev-libs/wayland
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
	>=sys-libs/glibc-2.35
	sys-devel/gcc:*[cxx]
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxcb
	x11-libs/libxkbcommon[X]
	x11-misc/xdg-utils
	x11-themes/hicolor-icon-theme
"

QA_PREBUILT="usr/bin/yamusic-rs"

src_install() {
	dobin usr/bin/yamusic-rs
	domenu usr/share/applications/yamusic-rs.desktop

	insinto /usr/share/icons
	doins -r usr/share/icons/hicolor

	dodoc usr/share/doc/yamusic-rs/copyright
}
