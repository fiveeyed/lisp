# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit common-lisp-2

DESCRIPTION="Common Lisp implementation of the Rails routes system for mapping URLs."
HOMEPAGE="http://code.google.com/p/cl-routes/"
SRC_URI="http://cl-routes.googlecode.com/files/${P}.tar.bz2"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lisp/iterate
		dev-lisp/puri
		dev-lisp/split-sequence
		dev-lisp/lift"

CLSYSTEMS="routes routes-test"

src_install() {
	common-lisp-install *.asd routes unify t
	common-lisp-symlink-asdf
}
