# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GitHub CLI"
HOMEPAGE="https://github.com/cli/cli"
SRC_URI="
	amd64? (
		https://github.com/cli/cli/releases/download/v${PV}/gh_${PV}_linux_amd64.tar.gz
			-> ${P}-amd64.tar.gz
	)
"
S=${WORKDIR}/gh_${PV}_linux_amd64

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* amd64"

RDEPEND=">=dev-vcs/git-1.7.3"

QA_PREBUILT="usr/bin/gh"
RESTRICT="strip"

src_install() {
	dobin bin/gh
	doman share/man/man1/*
}
