# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Kimi Code CLI coding agent (prebuilt)"
HOMEPAGE="https://www.kimi.com/code/ https://github.com/MoonshotAI/kimi-code"
SRC_URI="
	https://github.com/MoonshotAI/kimi-code/releases/download/%40moonshot-ai/kimi-code%40${PV}/kimi-code-linux-x64.tar.gz -> ${P}-amd64.tar.gz
	https://raw.githubusercontent.com/MoonshotAI/kimi-code/%40moonshot-ai/kimi-code%40${PV}/LICENSE -> ${P}-LICENSE
"
S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
REQUIRED_USE="elibc_glibc"
RESTRICT="strip"

RDEPEND="
	app-misc/ca-certificates
	dev-vcs/git
	>=sys-libs/glibc-2.28
	sys-devel/gcc:*[cxx]
"

QA_PREBUILT="usr/bin/kimi"

src_install() {
	dobin kimi
	newdoc "${DISTDIR}/${P}-LICENSE" LICENSE
}
