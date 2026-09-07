# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python SDK for the Model Context Protocol"
HOMEPAGE="https://modelcontextprotocol.io https://github.com/modelcontextprotocol/python-sdk"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/anyio-4.9[${PYTHON_USEDEP}]
	>=dev-python/cryptography-3.4[${PYTHON_USEDEP}]
	>=dev-python/httpx2-2.5[${PYTHON_USEDEP}]
	~dev-python/mcp-types-${PV}[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.20[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-api-1.28[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.10.1[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.0[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/sse-starlette-3.0[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.48[${PYTHON_USEDEP}]
	>=dev-python/typer-0.16[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.13[${PYTHON_USEDEP}]
	>=dev-python/typing-inspection-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.31.1[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/uv-dynamic-versioning[${PYTHON_USEDEP}]"

python_compile() {
	local -x UV_DYNAMIC_VERSIONING_BYPASS=${PV}

	distutils-r1_python_compile
}
