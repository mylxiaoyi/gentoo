# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils versionator multilib git-2

DESCRIPTION="A mesh processing system"
HOMEPAGE="http://meshlab.sourceforge.net/"
MY_PV="$(delete_all_version_separators ${PV})"
EGIT_REPO_URI="https://github.com/mylxiaoyi/meshlab"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-cpp/eigen:3
	dev-cpp/muParser
	dev-qt/qtcore:5
	dev-qt/qtopengl:5
	media-libs/glew
	media-libs/qhull
	=media-libs/lib3ds-1*
	media-libs/openctm
	sci-libs/levmar
	sys-libs/libunwind
	sci-libs/mpir"
RDEPEND="${DEPEND}"

S="${WORKDIR}/meshlab/src"

src_prepare() {
	cd "${WORKDIR}"
}

src_configure() {
	cd "${S}/meshlab/src"
	cd external && qmake external.pro
	cd .. && qmake meshlab_full.pro
}

src_compile() {
	cd "${S}/meshlab/src"
	cd external && emake
	cd .. && emake
}

src_install() {
	cd "${S}/meshlab/src"
	dobin distrib/{meshlab,meshlabserver}
	dolib distrib/libcommon.so.1.0.0
	dosym libcommon.so.1.0.0 /usr/$(get_libdir)/libcommon.so.1
	dosym libcommon.so.1 /usr/$(get_libdir)/libcommon.so

	exeinto /usr/$(get_libdir)/meshlab/plugins
	doexe distrib/plugins/*.so

	insinto /usr/share/meshlab/shaders
	doins -r distrib/shaders/*
	newicon "${S}"/meshlab/src/meshlab/images/eye64.png "${PN}".png
	make_desktop_entry meshlab "Meshlab"
}
