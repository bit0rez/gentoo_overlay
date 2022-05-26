# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ClickHouse common static libraries"
HOMEPAGE="https://clickhouse.tech/"
SRC_URI="https://repo.clickhouse.tech/tgz/lts/${P}.tgz"

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
	dobin usr/bin/clickhouse-library-bridge

	insinto /usr/bin
	doins usr/bin/clickhouse-extract-from-config

	insinto /
	doins -r usr/share/bash-completion/*

	dodoc -r usr/share/doc/clickhouse-common-static/*
}
