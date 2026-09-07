# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Turn source trees into locally queryable knowledge graphs"
HOMEPAGE="https://graphify.com https://github.com/Graphify-Labs/graphify"
SRC_URI="https://github.com/Graphify-Labs/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/networkx-3.4[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.21[${PYTHON_USEDEP}]
	>=dev-python/rapidfuzz-3.0[${PYTHON_USEDEP}]
	>=dev-python/mcp-1[${PYTHON_USEDEP}]
	<dev-python/mcp-3[${PYTHON_USEDEP}]
	>=dev-python/starlette-1.3.1[${PYTHON_USEDEP}]
	<dev-python/starlette-2[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-0.23[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-0.26[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-go-0.23[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-go-0.26[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-java-0.23[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-java-0.25[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-kotlin-1[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-kotlin-2[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-sql-0.3[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-sql-1[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-typescript-0.23[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-typescript-0.25[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-yaml-0.7[${PYTHON_USEDEP}]
	<dev-python/tree-sitter-yaml-1[${PYTHON_USEDEP}]
	>=dev-libs/tree-sitter-bash-0.23[python,${PYTHON_USEDEP}]
	<dev-libs/tree-sitter-bash-0.27[python,${PYTHON_USEDEP}]
	>=dev-libs/tree-sitter-c-0.23[python,${PYTHON_USEDEP}]
	<dev-libs/tree-sitter-c-0.25[python,${PYTHON_USEDEP}]
	>=dev-libs/tree-sitter-cpp-0.23[python,${PYTHON_USEDEP}]
	<dev-libs/tree-sitter-cpp-0.25[python,${PYTHON_USEDEP}]
	>=dev-libs/tree-sitter-javascript-0.23[python,${PYTHON_USEDEP}]
	<dev-libs/tree-sitter-javascript-0.26[python,${PYTHON_USEDEP}]
	>=dev-libs/tree-sitter-json-0.23[python,${PYTHON_USEDEP}]
	<dev-libs/tree-sitter-json-0.26[python,${PYTHON_USEDEP}]
	>=dev-libs/tree-sitter-lua-0.2[python,${PYTHON_USEDEP}]
	<dev-libs/tree-sitter-lua-0.6[python,${PYTHON_USEDEP}]
	>=dev-libs/tree-sitter-python-0.23[python,${PYTHON_USEDEP}]
	<dev-libs/tree-sitter-python-0.26[python,${PYTHON_USEDEP}]
	>=dev-libs/tree-sitter-ruby-0.23[python,${PYTHON_USEDEP}]
	<dev-libs/tree-sitter-ruby-0.25[python,${PYTHON_USEDEP}]
	>=dev-libs/tree-sitter-rust-0.23[python,${PYTHON_USEDEP}]
	<dev-libs/tree-sitter-rust-0.25[python,${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/setuptools-77[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all

	dodoc CHANGELOG.md NOTICE
}

pkg_postinst() {
	einfo "Run 'graphify install' to register the skill with a supported AI assistant."
	einfo "Run 'graphify-mcp GRAPH_JSON' to expose a graph over MCP stdio."
	einfo "Installed language grammars include Go, Rust, TypeScript, Lua,"
	einfo "JavaScript, Kotlin, C, C++, Java, Python, SQL, and YAML."
}
