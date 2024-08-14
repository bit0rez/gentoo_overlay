# Copyright 1999-2021 Gentoo
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Unofficial repack of Yandex Music Player"

SRC_URI="https://github.com/cucumber-sp/yandex-music-linux/releases/download/v${PV}/yandex-music_${PV}_x64.tar.gz"
HOMEPAGE="https://github.com/cucumber-sp/yandex-music-linux"

KEYWORDS="amd64 ~x86"
SLOT="0"
LICENSE="MIT"

S=${WORKDIR}

src_install() {
	cd "${WORKDIR}/${P}"

	insinto /usr
	doins -r usr/*
	fperms 755 /usr/bin/yandex-music
	fperms 755 /usr/lib/yandex-music/electron/electron
}
