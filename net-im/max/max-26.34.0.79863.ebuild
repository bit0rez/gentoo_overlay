# Copyright 1999-2021 Gentoo
# Distributed under the terms of the GNU General Public License v1

EAPI=8
inherit unpacker

DESCRIPTION="Not Official ebuild of Official MAX messenger"
HOMEPAGE="https://max.ru/"
SRC_URI="https://download.max.ru/linux/deb/pool/main/m/max/MAX-${PV}.deb"
S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 -x86"

RESTRICT="strip"

QA_PREBUILT="opt/max/*"

src_install() {
	sed -i \
		-e 's#/usr/share/max/bin#/opt/max/bin#g' \
		-e '/^DBusActivatable=/d' \
		usr/share/applications/max.desktop || die

	insinto /usr/share
	doins -r usr/share/{applications,icons,pixmaps}

	insinto /opt/max
	doins -r usr/share/max/*

	fperms 755 /opt/max/bin/max

	dosym -r /opt/max/bin/max /usr/bin/max
}
