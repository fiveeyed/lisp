# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3

DESCRIPTION="A native Common Lisp LDAP client implementation of part of RFC 2251."
HOMEPAGE="http://homepage.mac.com/ignavusinfo/trivial-ldap/ http://www.cliki.net/trivial-ldap"
SRC_URI="http://homepage.mac.com/ignavusinfo/${PN}/${P}.tar.gz"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lisp/usocket
		 dev-lisp/cl-plus-ssl"

src_install() {
	common-lisp-install-sources ${PN}.lisp
	common-lisp-install-asdf
	dohtml trivial-ldap.html
	docinto examples && dodoc example.lisp
}
