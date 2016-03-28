# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools-utils

DESCRIPTION="Constrained Column approximate minimum degree ordering algorithm"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/ccolamd/"
SRC_URI="http://localhost/mydoc/gentoo/SuiteSparse-4.5.1.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="amd64 ~arm hppa ~mips ppc ppc64 sparc x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

RDEPEND="sci-libs/suitesparseconfig"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/SuiteSparse"

src_configure() {
	cd "${S}"
}

src_compile() {
	cd "${S}/CCOLAMD" && emake
}

src_install() {
	cd "${S}"
	dolib lib/libccolamd.so.2.9.4
	dosym libccolamd.so.2.9.4 /usr/lib/libccolamd.so.2
	dosym libccolamd.so.2 /usr/lib/libccolamd.so
	insinto /usr/include
	doins include/ccolamd.h
}
