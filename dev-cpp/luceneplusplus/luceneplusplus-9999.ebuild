# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [ "${PV#9999}" != "${PV}" ] ; then
	SCM="git-r3"
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/rel_${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake-utils ${SCM}

MY_PN="LucenePlusPlus"

DESCRIPTION="Up to date C++ port of the popular Java Lucene library"
HOMEPAGE="https://github.com/luceneplusplus/LucenePlusPlus"

LICENSE="LGPL-3 Apache-2.0"
SLOT="0"
IUSE="doc test"

RDEPEND="
	dev-libs/boost[threads]
"
DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-cpp/gtest )
"

#PATCHES=(
#	"${FILESDIR}/system-gtest.patch"
#)

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
		$(cmake-utils_use_enable doc DOCS)
		-DUSE_SYSTEM_GTEST=ON
	)

	cmake-utils_src_configure
}

src_test() {
	"${BUILD_DIR}"/src/test/lucene++-tester --test_dir="${S}"/src/test/testfiles/ || die "tests failed"
}
