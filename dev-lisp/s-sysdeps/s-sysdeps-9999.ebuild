# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit common-lisp-3 git-r3

DESCRIPTION="A Common Lisp abstraction layer over platform dependent functionality."
HOMEPAGE="https://github.com/svenvc/s-sysdeps"
EGIT_REPO_URI="git://github.com/svenvc/${PN}.git"

LICENSE="LLGPL-2.1"
SLOT="0"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}"
