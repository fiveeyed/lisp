# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3

DESCRIPTION="R. Scott McIntire's Common Lisp Random Number Library."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-random"
SRC_URI="mirror://debian/pool/main/c/cl-${PN}/cl-${PN}_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}
		dev-lisp/uffi"

S="${WORKDIR}"/cl-${P}

src_compile() {
	make linux || die "Cannot compile FFI glue"
}

src_install() {
	exeinto /usr/$(get_libdir)/${PN}
	doexe random.so
	common-lisp-install-sources *.lisp
	common-lisp-install-asdf
	dohtml ${PN}.html ob01.jpg
}
