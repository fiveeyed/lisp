# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3 eutils

DESCRIPTION="A simple library for generating a backtrace portably."
HOMEPAGE="http://common-lisp.net/project/trivial-backtrace"
SRC_URI="http://common-lisp.net/~sionescu/files/${P}.tar.bz2"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

CLSYSTEMS="${PN} ${PN}-test"

src_install() {
	common-lisp-install-sources dev test
	common-lisp-install-asdf
	dodoc *.config
}
