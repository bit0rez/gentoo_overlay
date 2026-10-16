# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenAI Codex CLI coding agent (prebuilt package)"
HOMEPAGE="https://github.com/openai/codex"
SRC_URI="
	amd64? (
		https://github.com/openai/codex/releases/download/rust-v${PV}/codex-package-x86_64-unknown-linux-musl.tar.gz
			-> ${P}-amd64.tar.gz
	)
	arm64? (
		https://github.com/openai/codex/releases/download/rust-v${PV}/codex-package-aarch64-unknown-linux-musl.tar.gz
			-> ${P}-arm64.tar.gz
	)
"
S=${WORKDIR}

# Includes bundled Rust crates, bubblewrap, voice runtime libraries and zsh.
LICENSE="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0
	CC0-1.0 CDLA-Permissive-2.0 ISC LGPL-2+ MIT MPL-2.0 Unicode-3.0 ZLIB ZSH
"
SLOT="0"
KEYWORDS="-* amd64 arm64"
REQUIRED_USE="elibc_glibc"
RESTRICT="strip"

# The main executables are static musl binaries, but the bundled voice
# runtime and zsh need glibc and the separate libtinfo ABI.
RDEPEND="
	!dev-util/codex
	>=sys-libs/glibc-2.38
	sys-libs/ncurses:0/6[tinfo]
	arm64? ( sys-devel/gcc:* )
"

QA_PREBUILT="usr/libexec/codex/*"

src_install() {
	# Preserve upstream's self-contained layout and resource checksums.
	# The daemon can copy this complete directory as a managed installation.
	local package_dir="/usr/libexec/codex"
	dodir "${package_dir}"
	cp -a bin codex-package.json codex-path codex-resources \
		"${ED}${package_dir}/" || die
	dosym ../libexec/codex/bin/codex /usr/bin/codex
	dosym ../libexec/codex/bin/codex-code-mode-host /usr/bin/codex-code-mode-host
}
