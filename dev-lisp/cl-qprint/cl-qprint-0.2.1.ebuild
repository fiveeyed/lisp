# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3

DESCRIPTION="Common Lisp Library for encoding/decoding strings in quoted-printable format."
HOMEPAGE="http://www.cliki.net/cl-qprint/"
SRC_URI="http://www.bobturf.org/software/${PN}/${P}.tar.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}"/${PN}
