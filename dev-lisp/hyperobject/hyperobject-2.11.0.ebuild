# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3

DESCRIPTION="Hyperobject is a Common Lisp library for representing objects."
HOMEPAGE="http://hyperobject.b9.com/
		http://www.cliki.net/hyperobject"
SRC_URI="http://files.b9.com/${PN}/${PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="!dev-lisp/cl-${PN}
		dev-lisp/kmrcl
		dev-lisp/rt
		dev-lisp/clsql"

src_unpack() {
	unpack ${A}
	tar xfz "${S}"/doc/html.tar.gz -C "${WORKDIR}"
}

src_prepare() {
	rm Makefile
}

src_install() {
	common-lisp-install-sources *.lisp examples
	common-lisp-install-asdf
	dodoc README
	use doc && dohtml -r "${WORKDIR}"/html/
}
