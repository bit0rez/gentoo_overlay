# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for the Objective-C Tree-sitter grammar"
HOMEPAGE="https://github.com/tree-sitter-grammars/tree-sitter-objc https://pypi.org/project/tree-sitter-objc/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/tree-sitter-0.23[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-0.26[${PYTHON_USEDEP}]
"
