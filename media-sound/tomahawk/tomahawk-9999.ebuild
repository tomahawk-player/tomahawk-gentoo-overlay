# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tomahawk/tomahawk-9999.ebuild,v 1.25 2014/05/07 17:36:48 johu Exp $

EAPI=5

KDE_REQUIRED="optional"
inherit kde4-base ${GIT_ECLASS}

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://download.tomahawk-player.org/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="git://github.com/tomahawk-player/${PN}.git"
	KEYWORDS=""
	if [[ ${PV} == 0.8.9999 ]]; then
		EGIT_BRANCH="stable-0.8"
	else
		EGIT_BRANCH=""
	fi
fi

DESCRIPTION="A multi-source social music player"
HOMEPAGE="http://tomahawk-player.org/"

LICENSE="GPL-3 BSD"
SLOT="0"
IUSE="debug +jabber +hatchet kde qt4 qt5 telepathy"

REQUIRED_USE="telepathy? ( kde )
^^ ( qt4 qt5 )"

DEPEND="
	app-crypt/qca:2[qt4?,qt5?]
	dev-cpp/sparsehash
	dev-libs/boost
	dev-libs/quazip[qt4?,qt5?]
	dev-libs/qtkeychain[qt4?,qt5?]
	>=media-libs/libechonest-2.2.0:=[qt4?,qt5?]
	>=media-libs/liblastfm-1.0.1[qt4?,qt5?]
	dev-cpp/luceneplusplus
	>=media-libs/taglib-1.8.0
	>=net-libs/gnutls-3.2
	jabber? ( net-libs/jreen[qt4?,qt5?] )
	hatchet? ( dev-cpp/websocketpp )
	!qt5? (
		>=dev-libs/libattica-0.4.0
		dev-libs/qjson
		dev-qt/designer:4
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
		dev-qt/qtgui:4
		dev-qt/qtsql:4[sqlite]
		dev-qt/qtsvg:4
		dev-qt/qtwebkit:4
		dev-qt/qttest:4
	)
	qt5? (
		kde-frameworks/attica:5
		dev-qt/designer:5
		dev-qt/qtcore:5
		dev-qt/qtconcurrent:5
		dev-qt/qtdbus:5
		dev-qt/qtsvg:5
		dev-qt/qtsql:5[sqlite]
		dev-qt/qtwebkit:5
		dev-qt/qtwidgets:5
		dev-qt/qttest:5
	)
	telepathy? ( net-libs/telepathy-qt[qt4?,qt5?] )
"
if [[ ${PV} != 9999 ]]; then
	DEPEND="${DEPEND}
	media-libs/phonon[qt4?,qt5?]
	"
fi
RDEPEND="${DEPEND}
        || ( >=app-crypt/qca-2.1[openssl] app-crypt/qca-ossl )
"

DOCS=( AUTHORS ChangeLog README.md )

src_configure() {
	local mycmakeargs=(
		-DWITH_CRASHREPORTER=OFF
		$(cmake-utils_use_with jabber Jreen)
		$(cmake-utils_use_build hatchet HATCHET)
		$(cmake-utils_use_with kde KDE4)
		$(cmake-utils_use_build !qt5 WITH_QT4)
		$(cmake-utils_use_with telepathy TelepathyQt)
	)

	if [[ ${PV} != *9999* ]]; then
		mycmakeargs+=( -DBUILD_RELEASE=ON )
	fi

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
