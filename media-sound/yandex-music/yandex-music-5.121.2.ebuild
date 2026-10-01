# Copyright 1999-2021 Gentoo
# Distributed under the terms of the GNU General Public License v1

EAPI=8
inherit desktop unpacker

DESCRIPTION="Official Yandex Music Player"
HOMEPAGE="https://music.yandex.ru/"
SRC_URI="https://music-desktop-application.s3.yandex.net/stable/Yandex_Music_amd64_${PV}.deb"
S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 -x86"

RDEPEND="
	app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/nss
	sys-apps/util-linux
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
"

src_prepare() {
	default

	sed -i 's/^Categories=Audio;$/Categories=AudioVideo;Audio;/' \
		usr/share/applications/yandexmusic.desktop || die
	gzip -dc usr/share/doc/yandexmusic/changelog.gz > "${T}/changelog" || die
}

src_install() {
	domenu usr/share/applications/yandexmusic.desktop

	insinto /usr/share/icons
	doins -r usr/share/icons/*

	insinto /opt
	doins -r opt/*

	fperms 755 /opt/Яндекс\ Музыка/yandexmusic

	dodoc "${T}/changelog"
}
