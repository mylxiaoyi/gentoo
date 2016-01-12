# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="A open driver for Kinect2"
HOMEPAGE="https://github.com/OpenKinect/libfreenect2"
EGIT_REPO_URI="git://github.com/OpenKinect/${PN}.git"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-libs/libusb-1.0.20
"
RDEPEND="${DEPEND}"

src_configure() {
	cmake-utils_src_configure
}
