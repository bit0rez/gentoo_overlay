# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ClickHouse client"
HOMEPAGE="https://clickhouse.tech/"
SRC_URI="https://repo.clickhouse.tech/tgz/lts/${P}.tgz"

LICENSE="APACHE v2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
IDEPEND="=dev-db/clickhouse-common-static-${PV}"
BDEPEND=""


src_install() {
	cd ${WORKDIR}/${P}
	insinto /
	doins -r etc

	insinto /usr
	doins -r usr/bin

	dodoc -r usr/share/doc/clickhouse-client/*
}
