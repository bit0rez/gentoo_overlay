# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Distributed graph issue tracker for AI agents"
HOMEPAGE="https://github.com/gastownhall/beads https://gastownhall.github.io/beads/"
SRC_URI="
	amd64? ( https://github.com/gastownhall/beads/releases/download/v${PV}/${PN}_${PV}_linux_amd64.tar.gz )
	arm64? ( https://github.com/gastownhall/beads/releases/download/v${PV}/${PN}_${PV}_linux_arm64.tar.gz )
"
S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* amd64 arm64"
REQUIRED_USE="elibc_glibc"

RDEPEND=">=sys-libs/glibc-2.34"

QA_PREBUILT="usr/bin/bd"
RESTRICT="strip"

src_install() {
	dobin bd
	dodoc CHANGELOG.md README.md
}

pkg_postinst() {
	einfo "Run 'bd init' in a project to initialize Beads."
	einfo "Before upgrading a repository with a Dolt remote, back it up with"
	einfo "'bd export --all' and follow the upstream migration guide."
}
