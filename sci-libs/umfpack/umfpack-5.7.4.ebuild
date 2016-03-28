# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools-utils toolchain-funcs

DESCRIPTION="Unsymmetric multifrontal sparse LU factorization library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/umfpack"
SRC_URI="http://localhost/mydoc/gentoo/SuiteSparse-4.5.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ~mips ppc ppc64 x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc +cholmod static-libs"

RDEPEND="
	>=sci-libs/amd-1.3
	sci-libs/suitesparseconfig
	virtual/blas
	cholmod? ( >=sci-libs/cholmod-2[-minimal] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( virtual/latex-base )"

S="${WORKDIR}/SuiteSparse"

src_configure() {
	cd "${S}"
}

src_compile() {
	cd "${S}/UMFPACK" && emake
}

src_install() {
	cd "${S}"
	dolib lib/libumfpack.so.5.7.4
	dosym libumfpack.so.5.7.4 /usr/lib/libumfpack.so.5
	dosym libumfpack.so.5 /usr/lib/libumfpack.so
	insinto /usr/include
	doins include/umfpack*
}
