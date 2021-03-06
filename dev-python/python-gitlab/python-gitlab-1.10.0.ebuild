# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{6,7} pypy pypy3 )
inherit distutils-r1

DESCRIPTION="python-gitlab is a Python package providing access to the GitLab server API.
It supports the v3 api of GitLab, and provides a CLI tool (gitlab)."

HOMEPAGE="https://github.com/gpocentek/python-gitlab"
SRC_URI="https://github.com/python-gitlab/python-gitlab/releases/download/v${PV}/python-gitlab-${PV}.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	>dev-python/requests-1[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
