# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib

MY_P=ecl-${PV}

DESCRIPTION="ECL is an embeddable Common Lisp implementation."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
HOMEPAGE="http://common-lisp.net/project/ecl/"
SLOT="0"
LICENSE="BSD LGPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="=dev-libs/gmp-4*
		app-text/texi2html
		>=dev-libs/boehm-gc-6.8"

IUSE="X c++ threads unicode"

PROVIDE="virtual/commonlisp"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# change LISP-IMPLEMENTATION-VERSION because upstream version for
	# live builds contains spaces which ASDF-BINARY-LOCATIONS doesn't like
	cp "${FILESDIR}"/${PV}/config.lsp.in "${S}"/src/lsp
	sed -i "s:@GENTOODATE@:$(date +%F):" "${S}"/src/lsp/config.lsp.in

	epatch "${FILESDIR}"/${PV}/headers-gentoo.patch
}

src_compile() {
	econf \
		--with-system-gmp \
		--enable-boehm=system \
		--enable-gengc \
		--enable-smallcons \
		$(use_enable x86 asmapply) \
		$(use_with c++ cxx) \
		$(use_enable threads) \
		$(use_with threads __thread) \
		$(use_enable unicode) \
		$(use_with X x) \
		$(use_with X clx) \
		|| die "econf failed"
	#parallel fails
	emake -j1 || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "Could not build ECL"

	dohtml doc/*.html
	dodoc ANNOUNCEMENT Copyright
	dodoc "${FILESDIR}"/README.Gentoo
}
