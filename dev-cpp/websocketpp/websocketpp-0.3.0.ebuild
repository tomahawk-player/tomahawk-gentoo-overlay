# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

if [ "${PV#9999}" != "${PV}" ] ; then
	SCM="git-r3"
	EGIT_REPO_URI="https://github.com/zaphoyd/${PN}.git"
else
	SRC_URI="https://github.com/zaphoyd/${PN}/archive/${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake-utils ${SCM}

DESCRIPTION="C++/Boost Asio based websocket client/server library"
HOMEPAGE="http://www.zaphoyd.com/websocketpp"

LICENSE="BSD"
SLOT="0"
IUSE="boost"

RDEPEND="
	boost? ( dev-libs/boost )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable !boost CPP11)
	)
	# Disable EXAMPLES as compilation is broken upstream
	# $(cmake-utils_use_build examples EXAMPLES)
	cmake-utils_src_configure
}
