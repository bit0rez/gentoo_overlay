# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python bindings for the Elixir Tree-sitter grammar"
HOMEPAGE="https://github.com/elixir-lang/tree-sitter-elixir https://pypi.org/project/tree-sitter-elixir/"
SRC_URI="https://github.com/elixir-lang/tree-sitter-elixir/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/tree-sitter-0.23[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-0.26[${PYTHON_USEDEP}]
"
