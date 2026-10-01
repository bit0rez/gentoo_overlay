# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Server-Sent Events support for Starlette"
HOMEPAGE="https://github.com/sysid/sse-starlette https://pypi.org/project/sse-starlette/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/anyio-4.7[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.49.1[${PYTHON_USEDEP}]
"
