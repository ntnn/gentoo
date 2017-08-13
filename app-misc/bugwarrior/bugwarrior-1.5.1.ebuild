# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Pull github, bitbucket, and trac issues into taskwarrior"
HOMEPAGE="https://github.com/ralphbean/bugwarrior"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="keyring jira bugzilla test"

RDEPEND="app-misc/task
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/dogpile-cache[${PYTHON_USEDEP}]
	dev-python/lockfile[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	keyring? (
		dev-python/keyring[${PYTHON_USEDEP}]
		dev-python/dbus-python[${PYTHON_USEDEP}]
	)
	jira? ( dev-python/jira[${PYTHON_USEDEP}] )
	bugzilla? ( dev-python/python-bugzilla[${PYTHON_USEDEP}] )
"
DEPEND="${RDPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
		app-misc/bugwarrior[jira,${PYTHON_USEDEP}]
		app-misc/bugwarrior[bugzilla,${PYTHON_USEDEP}]
	)
"

src_install() {
	distutils-r1_src_install

	dodoc -r bugwarrior/docs/*
}

src_test() {
	nosetests
}
