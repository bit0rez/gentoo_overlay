# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for the Swift Tree-sitter grammar"
HOMEPAGE="https://github.com/alex-pinkus/tree-sitter-swift https://pypi.org/project/tree-sitter-swift/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/tree-sitter-0.25[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-0.26[${PYTHON_USEDEP}]
"
