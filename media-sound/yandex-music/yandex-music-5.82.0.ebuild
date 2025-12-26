# Copyright 1999-2021 Gentoo
# Distributed under the terms of the GNU General Public License v1

EAPI=8
inherit unpacker

DESCRIPTION="Official Yandex Music Player"
SRC_URI="https://music-desktop-application.s3.yandex.net/stable/Yandex_Music_amd64_${PV}.deb"
HOMEPAGE="https://music.yandex.ru/"

KEYWORDS="amd64 ~x86"
SLOT="0"
LICENSE="MIT"

S=${WORKDIR}

src_install() {
	cd "${WORKDIR}/${P}"

	insinto /usr
	doins -r usr/*

	insinto /opt
	doins -r opt/*

	fperms 755 /opt/Яндекс\ Музыка/yandexmusic
}
