# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3

MY_PV=${PV:0:3}
CVS_PV=${PV:5:4}.${PV:9:2}.${PV:11}
FULL_PV=${MY_PV}+cvs.${CVS_PV}
MY_P=cl-${PN}_${FULL_PV}

DESCRIPTION="McIntire's Common Lisp RSA Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-rsa"
SRC_URI="mirror://debian/pool/main/c/cl-${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}
		dev-lisp/rsm-mod
		dev-lisp/rsm-string
		dev-lisp/cl-plus"

S="${WORKDIR}"/cl-${PN}

src_unpack() {
	unpack ${A}
}

src_prepare() {
	eapply "${FILESDIR}"/${PV}-gentoo-fix-defconstant.patch
	eapply_user
}

src_install() {
	common-lisp-install-sources *.lisp
	common-lisp-install-asdf
	dohtml ${PN}.html
}
