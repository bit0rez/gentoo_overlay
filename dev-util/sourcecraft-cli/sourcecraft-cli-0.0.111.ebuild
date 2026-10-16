# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="Command-line interface for the SourceCraft development platform"
HOMEPAGE="https://sourcecraft.dev/portal/docs/en/sourcecraft/operations/cli-quickstart"
SRC_URI="
	amd64? (
		https://s3.yandexcloud.net/sourcecraft-cli/releases/${PV}/linux_amd64/src.tar.gz
			-> ${P}-linux-amd64.tar.gz
	)
	arm64? (
		https://s3.yandexcloud.net/sourcecraft-cli/releases/${PV}/linux_arm64/src.tar.gz
			-> ${P}-linux-arm64.tar.gz
	)
	x86? (
		https://s3.yandexcloud.net/sourcecraft-cli/releases/${PV}/linux_386/src.tar.gz
			-> ${P}-linux-386.tar.gz
	)
"
S=${WORKDIR}

# Upstream does not provide a free-software license with the binary release.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="cpu_flags_x86_sse2"
REQUIRED_USE="x86? ( cpu_flags_x86_sse2 )"

RESTRICT="bindist mirror strip"

RDEPEND="
	app-misc/ca-certificates
	dev-vcs/git
"

QA_PREBUILT="usr/bin/src"

src_install() {
	dobin src
}

pkg_postinst() {
	optfeature "storing credentials in a desktop keyring" virtual/secret-service
	optfeature "opening browser authentication links" x11-misc/xdg-utils
}
