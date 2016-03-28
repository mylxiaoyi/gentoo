# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools-utils

DESCRIPTION="Algorithm for matrix permutation into block triangular form"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/btf/"
SRC_URI="http://localhost/mydoc/gentoo/SuiteSparse-4.5.1.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS=" ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

RDEPEND="sci-libs/suitesparseconfig"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/SuiteSparse"

src_configure() {
	cd "${S}"
}

src_compile() {
	cd "${S}/BTF" && emake
}

src_install() {
	cd "${S}"
	dolib lib/libbtf.so.1.2.4 
	dosym libbtf.so.1.2.4 /usr/lib/libbtf.so.1
	dosym libbtf.so.1 /usr/lib/libbtf.so
	insinto /usr/include
	doins include/*
}
