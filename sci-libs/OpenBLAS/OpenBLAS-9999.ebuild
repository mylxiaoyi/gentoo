# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit git-2

DESCRIPTION="An optimized BLAS library"
HOMEPAGE="http://www.openblas.net"
EGIT_REPO_URI="https://github.com/xianyi/OpenBLAS"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	USE_OPENMP=1 make
}

src_install() {
	make install PREFIX=/usr/local
}
