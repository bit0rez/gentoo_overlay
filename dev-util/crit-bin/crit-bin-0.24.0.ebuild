# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Browser-based review of AI coding agent plans, diffs and web apps"
HOMEPAGE="https://crit.md/ https://github.com/tomasz-tomczyk/crit"
SRC_URI="
	amd64? (
		https://github.com/tomasz-tomczyk/crit/releases/download/v${PV}/crit-linux-amd64
			-> ${P}-amd64
	)
	arm64? (
		https://github.com/tomasz-tomczyk/crit/releases/download/v${PV}/crit-linux-arm64
			-> ${P}-arm64
	)
	https://raw.githubusercontent.com/tomasz-tomczyk/crit/v${PV}/LICENSE
		-> ${P}.LICENSE
	https://raw.githubusercontent.com/tomasz-tomczyk/crit/v${PV}/README.md
		-> ${P}.README.md
"
S=${WORKDIR}

# Includes Go libraries, a bundled web UI and Excalidraw fonts.
LICENSE="Apache-2.0 BSD BSD-2 MIT OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"
REQUIRED_USE="amd64? ( elibc_glibc )"
RESTRICT="strip"

RDEPEND="
	app-misc/ca-certificates
	dev-vcs/git
	x11-misc/xdg-utils
	amd64? ( >=sys-libs/glibc-2.34 )
"

QA_PREBUILT="usr/bin/crit"

src_unpack() {
	:
}

src_install() {
	newbin "${DISTDIR}/${P}-${ARCH}" crit
	newdoc "${DISTDIR}/${P}.LICENSE" LICENSE
	newdoc "${DISTDIR}/${P}.README.md" README.md
}
