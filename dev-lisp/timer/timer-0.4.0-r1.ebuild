# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3

DESCRIPTION="An event scheduling library for SBCL by Zach Beane. It implements an interface similar to LispWorks' timer and scheduling functions."
HOMEPAGE="http://www.cliki.net/TIMER"
SRC_URI="http://www.xach.com/lisp/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lisp/sbcl"
