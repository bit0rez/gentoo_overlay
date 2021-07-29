# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ClickHouse common static libraries"
HOMEPAGE="https://clickhouse.tech/"
SRC_URI="https://repo.clickhouse.tech/tgz/${P}.tgz"

LICENSE="APACHE v2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	cd ${WORKDIR}/${P}
	dobin usr/bin/clickhouse
	dobin usr/bin/clickhouse-odbc-bridge

	insinto /usr/bin
	doins usr/bin/clickhouse-extract-from-config

	insinto /
	doins -r etc

	docinto /usr/share/doc/clickhouse-common-static
	dodoc -r usr/share/doc/clickhouse-common-static/
}
