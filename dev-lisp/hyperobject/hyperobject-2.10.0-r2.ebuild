# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp-2

DESCRIPTION="Hyperobject is a Common Lisp library for representing objects."
HOMEPAGE="http://hyperobject.b9.com/
		http://www.cliki.net/hyperobject"
SRC_URI="http://files.b9.com/${PN}/${PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}
		dev-lisp/kmrcl
		dev-lisp/rt
		dev-lisp/clsql"

src_unpack() {
	unpack ${A}
	rm "${S}"/Makefile
}

src_install() {
	common-lisp-install *.{lisp,asd} examples
	common-lisp-symlink-asdf
	dodoc README
	dodoc doc/*.pdf
	tar xfz doc/html.tar.gz -C "${T}"
	dohtml "${T}"/html/*
}
