# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenRC service for the QMD Streamable HTTP MCP server"
HOMEPAGE="https://github.com/tobi/qmd"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	acct-user/qmd
	~app-misc/qmd-${PV}
"

src_install() {
	newinitd "${FILESDIR}/${P}.initd" qmd-mcp

	newconfd "${FILESDIR}/${P}.confd" qmd-mcp
	newdoc "${FILESDIR}/${P}.README.Gentoo" README.Gentoo
}

pkg_postinst() {
	elog "qmd-mcp listens on 127.0.0.1:8181 by default."
	elog "Edit /etc/conf.d/qmd-mcp before starting the service if needed."
	elog "Service state is isolated from the old Rust index in /var/lib/qmd/tobi."
	elog "See /usr/share/doc/${PF}/README.Gentoo* for migration and setup."
	elog "To enable the service explicitly:"
	elog "  rc-update add qmd-mcp default"
}
