# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fast, lightweight, and fully autonomous AI assistant"
HOMEPAGE="https://zeroclawlabs.ai https://github.com/zeroclaw-labs/zeroclaw"
SRC_URI="
	amd64? (
		elibc_glibc? (
			https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${PV}/zeroclaw-x86_64-unknown-linux-gnu.tar.gz
		)
		elibc_musl? (
			https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${PV}/zeroclaw-x86_64-unknown-linux-musl.tar.gz
		)
	)
	arm64? (
		elibc_glibc? (
			https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${PV}/zeroclaw-aarch64-unknown-linux-gnu.tar.gz
		)
		elibc_musl? (
			https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${PV}/zeroclaw-aarch64-unknown-linux-musl.tar.gz
		)
	)
"

S=${WORKDIR}

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
REQUIRED_USE="^^ ( elibc_glibc elibc_musl )"

RESTRICT="strip"

RDEPEND="
	elibc_glibc? (
		>=sys-libs/glibc-2.34
		sys-devel/gcc:*[cxx]
	)
"

QA_PREBUILT="
	usr/bin/zeroclaw
	usr/bin/zerocode
"

src_install() {
	dobin zeroclaw zerocode

	insinto /usr/share/zeroclawlabs
	doins -r web
}

pkg_postinst() {
	einfo "Run 'zeroclaw quickstart' to configure your first agent."
	einfo "Use Portage to update ZeroClaw; the built-in updater cannot replace"
	einfo "system-managed files under ${EPREFIX}/usr."
}
