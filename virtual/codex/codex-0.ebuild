# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for OpenAI Codex CLI"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE="+binary"

RDEPEND="
	binary? ( dev-util/codex-bin )
	!binary? ( dev-util/codex )
"
