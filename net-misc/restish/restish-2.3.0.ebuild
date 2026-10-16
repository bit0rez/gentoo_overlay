# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Command-line client for REST APIs with OpenAPI support"
HOMEPAGE="https://rest.sh/ https://github.com/rest-sh/restish"
SRC_URI="
	amd64? (
		https://github.com/rest-sh/restish/releases/download/v${PV}/${P}-linux-amd64.tar.gz
	)
	arm64? (
		https://github.com/rest-sh/restish/releases/download/v${PV}/${P}-linux-arm64.tar.gz
	)
"
S=${WORKDIR}

# Includes licenses of the statically linked Go dependencies.
LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="strip"

RDEPEND="app-misc/ca-certificates"

QA_PREBUILT="usr/bin/restish"

src_install() {
	dobin restish
	dodoc LICENSE.md README.md
}
