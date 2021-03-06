# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3

MYPF="Parenscript-${PV}"

DESCRIPTION="Parenscript is a small lispy language that can be compiled to JavaScript."
HOMEPAGE="http://common-lisp.net/project/parenscript/"
SRC_URI="http://common-lisp.net/project/${PN}/release/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="!dev-lisp/cl-${PN}
		!dev-lisp/cl-${PN}-darcs
		!dev-lisp/${PN}-darcs
		dev-lisp/anaphora
		dev-lisp/cl-ppcre
		dev-lisp/fiveam
		dev-lisp/named-readtables"

S="${WORKDIR}/${MYPF}"

CLSYSTEMS="parenscript parenscript.test"

# TODO: install extras/js-expander.el
src_install() {
	common-lisp-install-sources extras runtime src t
	common-lisp-install-asdf
	dodoc contributors
	if use doc ; then
		dodoc docs/introduction.lisp
		dohtml -r docs
	fi
}
