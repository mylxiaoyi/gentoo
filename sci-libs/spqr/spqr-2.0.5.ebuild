# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools-utils

DESCRIPTION="Multithreaded multifrontal sparse QR factorization library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/SPQR"
SRC_URI="http://localhost/mydoc/gentoo/SuiteSparse-4.5.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc metis static-libs tbb"
RDEPEND="
	virtual/lapack
	>=sci-libs/cholmod-2[metis?]
	tbb? ( dev-cpp/tbb )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( virtual/latex-base )"

S="${WORKDIR}/SuiteSparse"

src_configure() {
	cd "${S}"
}

src_compile() {
	cd "${S}/SPQR" && emake CUDA=no
}

src_install() {
	cd "${S}"
	dolib lib/libspqr.so.2.0.5
	dosym libspqr.so.2.0.5 /usr/lib/libspqr.so.2
	dosym libspqr.so.2 /usr/lib/libspqr.so
	insinto /usr/include
	doins include/{spqr.hpp,SuiteSparseQR_C.h,SuiteSparseQR_definitions.h,SuiteSparseQR.hpp}
}
