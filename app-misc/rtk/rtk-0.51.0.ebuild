# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="CLI proxy that reduces LLM token usage by filtering command output"
HOMEPAGE="https://www.rtk-ai.app https://github.com/rtk-ai/rtk"
SRC_URI="
	amd64? (
		https://github.com/rtk-ai/rtk/releases/download/v${PV}/${PN}-x86_64-unknown-linux-musl.tar.gz
			-> ${P}-amd64.tar.gz
	)
"
S=${WORKDIR}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* amd64"

QA_PREBUILT="usr/bin/rtk"
RESTRICT="strip"

src_install() {
	dobin rtk
}

pkg_postinst() {
	einfo "Run 'rtk init' in a project to enable command rewriting."
	einfo "Run 'rtk init --global' to configure RTK for all supported projects."
}
