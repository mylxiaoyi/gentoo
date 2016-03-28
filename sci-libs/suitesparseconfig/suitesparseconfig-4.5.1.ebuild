# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools-utils

DESCRIPTION="Common configurations for all packages in suitesparse"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/SuiteSparse_config"
SRC_URI="http://localhost/mydoc/gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ~mips ppc ppc64 sparc x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"


src_prepare() {
	cd "${S}"
}

src_configure() {
	cd "${S}"
}

src_compile() {
	cd "${S}" && emake
}

src_install() {
	cd "${WORKDIR}"
	dolib lib/libsuitesparseconfig.so.4.5.1
	dosym libsuitesparseconfig.so.4.5.1 /usr/lib/libsuitesparseconfig.so.4
	dosym libsuitesparseconfig.so.4     /usr/lib/libsuitesparseconfig.so
	insinto /usr/include
	doins include/*
}
