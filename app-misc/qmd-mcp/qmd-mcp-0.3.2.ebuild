# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenRC service for the QMD Streamable HTTP MCP server"
HOMEPAGE="https://github.com/qntx-labs/qmd"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	acct-user/qmd
	~app-misc/qmd-${PV}
"

src_install() {
	newinitd "${FILESDIR}"/qmd-mcp.initd qmd-mcp

	newconfd "${FILESDIR}"/qmd-mcp.confd qmd-mcp
}

pkg_postinst() {
	elog "qmd-mcp listens on 127.0.0.1:8181 by default."
	elog "Edit /etc/conf.d/qmd-mcp before starting the service if needed."
	elog "The service is installed disabled; enable it explicitly with:"
	elog "  rc-update add qmd-mcp default"
}
