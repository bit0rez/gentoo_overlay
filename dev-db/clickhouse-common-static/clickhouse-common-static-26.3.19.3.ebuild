# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ClickHouse common static libraries"
HOMEPAGE="https://clickhouse.com/"
SRC_URI="https://packages.clickhouse.com/tgz/lts/${P}-amd64.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="strip"
QA_PREBUILT="usr/bin/clickhouse"

src_install() {
	dobin usr/bin/clickhouse
	dosym -r /usr/bin/clickhouse /usr/bin/clickhouse-extract-from-config

	insinto /usr/share
	doins -r usr/share/bash-completion usr/share/clickhouse

	dodoc -r usr/share/doc/clickhouse-common-static/*
}
