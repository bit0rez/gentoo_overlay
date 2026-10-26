# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Git-native knowledge validation, retrieval and MCP runtime (prebuilt)"
HOMEPAGE="https://openknowledge.sh https://github.com/openknowledge-sh/openknowledge"
SRC_URI="
	amd64? (
		https://github.com/openknowledge-sh/openknowledge/releases/download/v${PV}/openknowledge_linux_amd64.tar.gz
			-> ${P}-amd64.tar.gz
	)
	arm64? (
		https://github.com/openknowledge-sh/openknowledge/releases/download/v${PV}/openknowledge_linux_arm64.tar.gz
			-> ${P}-arm64.tar.gz
	)
"
S=${WORKDIR}

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="strip"

RDEPEND="
	app-misc/ca-certificates
	dev-vcs/git
"

QA_PREBUILT="usr/bin/openknowledge"

src_install() {
	dobin openknowledge
	dosym openknowledge /usr/bin/okn

	dodoc README.md THIRD_PARTY_NOTICES.md
	dodoc -r third_party/licenses
}
