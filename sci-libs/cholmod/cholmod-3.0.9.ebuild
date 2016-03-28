# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools-utils multilib toolchain-funcs

DESCRIPTION="Sparse Cholesky factorization and update/downdate library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/cholmod/"
SRC_URI="http://localhost/mydoc/gentoo/SuiteSparse-4.5.1.tar.gz"

LICENSE="minimal? ( LGPL-2.1 ) !minimal? ( GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ~mips ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="cuda doc lapack metis minimal static-libs"

RDEPEND="
	>=sci-libs/amd-2.3
	>=sci-libs/colamd-2.8
	cuda? ( x11-drivers/nvidia-drivers dev-util/nvidia-cuda-toolkit )
	lapack? ( virtual/lapack )
	metis? (
		>=sci-libs/camd-2.3
		>=sci-libs/ccolamd-2.8
		|| ( sci-libs/metis sci-libs/parmetis ) )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( virtual/latex-base )"

S="${WORKDIR}/SuiteSparse"

src_configure() {
	cd "${S}"
}

src_compile() {
	cd "${S}/CHOLMOD" && emake
}

src_install() {
	cd "${S}"
	dolib lib/libcholmod.so.3.0.9
	dosym libcholmod.so.3.0.9 /usr/lib/libcholmod.so.3
	dosym libcholmod.so.3 /usr/lib/libcholmod.so
	insinto /usr/include
	doins include/cholmod*
}
