# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3

DESCRIPTION="Portable FFI library for Common Lisp."
HOMEPAGE="http://www.cliki.net/UFFI http://uffi.kpe.io/"
SRC_URI="http://files.kpe.io/${PN}/${PF}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc examples"

src_prepare() {
	rm -f tests/*dylib
	eapply_user
}

src_install() {
	common-lisp-install-sources src
	common-lisp-install-sources -t all tests
	common-lisp-install-asdf

	dodoc AUTHORS ChangeLog NEWS README TODO

	if use doc ; then
		dodoc doc/uffi.pdf

		tar xfz doc/html.tar.gz -C "${T}" || die
		dohtml "${T}"/html/*
	fi

	if use examples ; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples && dodoc examples/*.{lisp,c}
		docompress -x "/usr/share/doc/${PF}/benchmarks"
		docinto benchmarks && dodoc benchmarks/*.lisp
	fi
}
