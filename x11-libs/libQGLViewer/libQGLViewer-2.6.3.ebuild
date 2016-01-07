# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit qt5-build qmake-utils multilib flag-o-matic

DESCRIPTION="C++ library based on Qt that eases the creation of OpenGL 3D viewers"
HOMEPAGE="http://www.libqglviewer.com"
SRC_URI="http://www.libqglviewer.com/src/${P}.tar.gz"

MY_P="${P}"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="designer examples"

DEPEND="virtual/opengl
	virtual/glu
	dev-qt/qtopengl:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}
	designer? ( dev-qt/designer:5 )"

src_configure() {
	append-ldflags "-L${S}/QGLViewer"
	sed -e 's#designerPlugin##' -i ${P}.pro || die
	use examples || sed -e 's#examples examples/contribs##' -i ${P}.pro || die
	eqmake5 ${P}.pro \
		PREFIX="${EPREFIX}/usr" \
		LIB_DIR="${EPREFIX}/usr/$(get_libdir)" \
		DOC_DIR="${EPREFIX}/usr/share/doc/${PF}/html"
	if use designer ; then
		cd "${S}/designerPlugin"
		eqmake5 designerPlugin.pro
	fi
}

src_compile() {
	if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then
		emake || die "emake failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	dodoc README

	if use designer ; then
		cd "${S}/designerPlugin"
		emake INSTALL_ROOT="${D}" install
	fi

	if use examples ; then
		exeinto /usr/bin/${PN}-examples
		doexe $(find "${S}/examples" -type f -executable ! -name '*.vcproj')
	fi
}
