# Copyright 1999-2021 Gentoo
# Distributed under the terms of the GNU General Public License v1

EAPI=8
inherit unpacker

DESCRIPTION="Not Official ebuild of Official MAX messenger"
SRC_URI="https://download.max.ru/linux/deb/pool/main/m/max/MAX-${PV}.deb"
HOMEPAGE="https://max.ru/"

KEYWORDS="amd64 ~x86"
SLOT="0"
LICENSE="MIT"

S=${WORKDIR}

src_install() {
	cd "${WORKDIR}/${P}"

	sed -i 's#/usr/share/max/bin#/opt/max/bin#g' usr/share/applications/max.desktop
	sed -i 's#/usr/share/max/bin#/opt/max/bin#g' usr/share/applications/MAX.desktop

	insinto /usr/share
	doins -r usr/share/{applications,icons,pixmaps}


	insinto /opt/max
	doins -r usr/share/max/*

	fperms 755 /opt/max/bin/max

	dosim -r /opt/max/bin/max /usr/bin/max
}
