# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3 eutils

MY_P=${PN}_${PV}

DESCRIPTION="Ensures consistent *FEATURES* across multiple Common Lisp implementations."
HOMEPAGE="http://www.cliki.net/trivial-features"
SRC_URI="http://common-lisp.net/~loliveira/tarballs/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}"/${MY_P}

src_install() {
	common-lisp-3_src_install
	dodoc SPEC
}
