# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework providing transparent file and data management"
SRC_URI+=" https://dev.gentoo.org/~asturm/distfiles/${P}-revert-new-uds-implementation.tar.xz"

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="acl +handbook kerberos +kwallet X"

RDEPEND="
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork 'ssl')
	$(add_qt_dep qtscript)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	dev-libs/libxml2
	dev-libs/libxslt
	acl? (
		sys-apps/attr
		virtual/acl
	)
	handbook? ( $(add_frameworks_dep kdoctools) )
	kerberos? ( virtual/krb5 )
	kwallet? ( $(add_frameworks_dep kwallet) )
	X? ( $(add_qt_dep qtx11extras) )
"
DEPEND="${RDEPEND}
	$(add_qt_dep qtconcurrent)
	test? ( sys-libs/zlib )
	X? (
		x11-base/xorg-proto
		x11-libs/libX11
		x11-libs/libXrender
	)
"
PDEPEND="
	$(add_frameworks_dep kded)
"

# tests hang
RESTRICT+=" test"

PATCHES=( "${WORKDIR}/${P}-revert-new-uds-implementation.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package acl ACL)
		$(cmake-utils_use_find_package handbook KF5DocTools)
		$(cmake-utils_use_find_package kerberos GSSAPI)
		$(cmake-utils_use_find_package kwallet KF5Wallet)
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}
