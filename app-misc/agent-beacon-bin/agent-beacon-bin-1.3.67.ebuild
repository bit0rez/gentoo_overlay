# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Local telemetry and session history for AI coding agents (prebuilt)"
HOMEPAGE="https://beacon.sh/ https://github.com/Asymptote-Labs/agent-beacon"
SRC_URI="
	amd64? (
		https://github.com/Asymptote-Labs/agent-beacon/releases/download/v${PV}/beacon_${PV}_linux_amd64.tar.gz
	)
	arm64? (
		https://github.com/Asymptote-Labs/agent-beacon/releases/download/v${PV}/beacon_${PV}_linux_arm64.tar.gz
	)
	https://raw.githubusercontent.com/Asymptote-Labs/agent-beacon/v${PV}/LICENSE
		-> ${P}.LICENSE
"
S=${WORKDIR}

# Includes the OpenTelemetry Collector and Vector.
LICENSE="Apache-2.0 MIT MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="strip"

RDEPEND="app-misc/ca-certificates"

QA_PREBUILT="usr/bin/beacon usr/bin/beacon-hooks usr/bin/beacon-otelcol usr/bin/beacon-vector"

src_unpack() {
	unpack "beacon_${PV}_linux_${ARCH}.tar.gz"
}

src_install() {
	dobin beacon beacon-hooks beacon-otelcol beacon-vector
	dodoc README.md
	newdoc "${DISTDIR}/${P}.LICENSE" LICENSE
}
