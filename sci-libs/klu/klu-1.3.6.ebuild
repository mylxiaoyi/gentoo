# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools-utils

DESCRIPTION="Sparse LU factorization for circuit simulation"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/klu/"
SRC_URI="http://localhost/mydoc/gentoo/SuiteSparse-4.5.1.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc static-libs"

RDEPEND="
	>=sci-libs/amd-1.3
	>=sci-libs/btf-1.2
	>=sci-libs/colamd-1.3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( virtual/latex-base )"

S="${WORKDIR}/SuiteSparse"

src_configure() {
	cd "${S}"
}

src_compile() {
	cd "${S}/KLU" && emake
}

src_install() {
	cd "${S}"
	dolib lib/libklu.so.1.3.6
	dosym libklu.so.1.3.6 /usr/lib/libklu.so.1
	dosym libklu.so.1 /usr/lib/libklu.so
	insinto /usr/include
	doins include/klu.h
}
