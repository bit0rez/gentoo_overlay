# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Wire types for the Model Context Protocol"
HOMEPAGE="https://modelcontextprotocol.io https://github.com/modelcontextprotocol/python-sdk"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/pydantic-2.12[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.13[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/uv-dynamic-versioning[${PYTHON_USEDEP}]"

python_compile() {
	local -x UV_DYNAMIC_VERSIONING_BYPASS=${PV}

	distutils-r1_python_compile
}
