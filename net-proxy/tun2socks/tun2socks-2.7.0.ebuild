# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Userspace network stack for proxying TUN traffic"
HOMEPAGE="https://github.com/xjasonlyu/tun2socks"
SRC_URI="
	amd64? (
		https://github.com/xjasonlyu/tun2socks/releases/download/v${PV}/${PN}-linux-amd64.zip
			-> ${P}-linux-amd64.zip
	)
	arm64? (
		https://github.com/xjasonlyu/tun2socks/releases/download/v${PV}/${PN}-linux-arm64.zip
			-> ${P}-linux-arm64.zip
	)
"

S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* amd64 arm64"

QA_PREBUILT="usr/bin/tun2socks"
RESTRICT="strip"

BDEPEND="app-arch/unzip"

src_install() {
	local arch

	case ${ARCH} in
		amd64) arch=amd64 ;;
		arm64) arch=arm64 ;;
		*) die "Unsupported architecture: ${ARCH}" ;;
	esac

	newbin "${PN}-linux-${arch}" "${PN}"

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"

	insinto "/etc/${PN}"
	insopts -m 0640
	newins "${FILESDIR}/config.yaml" config.yaml
}

pkg_postinst() {
	elog "Edit /etc/tun2socks/config.yaml before starting the service."
	elog "The default proxy is socks5://127.0.0.1:1080; tun2socks does not"
	elog "change system routes unless routing hooks are configured explicitly."
	elog "Enable the service with:"
	elog "  rc-update add tun2socks default"
}
