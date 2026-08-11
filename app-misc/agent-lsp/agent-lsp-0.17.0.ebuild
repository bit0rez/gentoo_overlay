# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="MCP server that orchestrates language servers for AI agents"
HOMEPAGE="https://github.com/blackwell-systems/agent-lsp https://www.agent-lsp.com/"
SRC_URI="
	amd64? (
		https://github.com/blackwell-systems/agent-lsp/releases/download/v${PV}/${PN}_linux_amd64.tar.gz
			-> ${P}_linux_amd64.tar.gz
	)
	arm64? (
		https://github.com/blackwell-systems/agent-lsp/releases/download/v${PV}/${PN}_linux_arm64.tar.gz
			-> ${P}_linux_arm64.tar.gz
	)
"
S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* amd64 arm64"

QA_PREBUILT="usr/bin/agent-lsp"
RESTRICT="strip"

src_install() {
	dobin agent-lsp
	dodoc CHANGELOG.md README.md
}

pkg_postinst() {
	einfo "Install the language servers needed for your projects, then run"
	einfo "'agent-lsp init' to configure your AI tools."
	einfo "Use Portage to update agent-lsp; the built-in updater cannot replace"
	einfo "system-managed files under ${EPREFIX}/usr."
}
