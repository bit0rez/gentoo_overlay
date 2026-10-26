# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Compliance linter for Open Knowledge Format documentation"
HOMEPAGE="https://github.com/mattdav/okflint https://mattdav.github.io/okflint/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/beartype-0.22.9[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
"

# Coverage reporting is an upstream development check, not a test dependency.
EPYTEST_PLUGINS=()
EPYTEST_EXTRA_ARGS=( -o addopts=--doctest-modules )
distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all

	dodoc CHANGELOG.md
	docompress -x /usr/share/doc/${PF}/examples
	docinto examples
	dodoc example/*
}
