# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit common-lisp-3

DESCRIPTION="Drakma is a Common Lisp HTTP client."
HOMEPAGE="http://weitz.de/drakma/"
SRC_URI="https://github.com/edicl/${PN}/archive/v${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}
		>=dev-lisp/chunga-1.1.0
		>=dev-lisp/cl-base64-3.3.2
		dev-lisp/cl-plus-ssl
		dev-lisp/cl-ppcre
		>=dev-lisp/puri-1.5.0
		>=dev-lisp/flexi-streams-1.0.7
		>=dev-lisp/usocket-0.4.0"