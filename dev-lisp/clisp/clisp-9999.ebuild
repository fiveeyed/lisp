# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

EGIT_REPO_URI="git://git.boinkor.net/clisp.git"

inherit flag-o-matic eutils toolchain-funcs multilib git

DESCRIPTION="A portable, bytecode-compiled implementation of Common Lisp"
HOMEPAGE="http://clisp.sourceforge.net/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="-sparc"
IUSE="-jit -threads +unicode X new-clx dbus fastcgi gdbm gtk pari +pcre postgres +readline svm +zlib hyperspec"

RESTRICT="strip"

RDEPEND="virtual/libiconv
		 >=dev-libs/libsigsegv-2.4
		 >=dev-libs/ffcall-1.10
		 jit? ( >=dev-libs/lightning-1.2 )
		 dbus? ( sys-apps/dbus )
		 fastcgi? ( dev-libs/fcgi )
		 gdbm? ( sys-libs/gdbm )
		 gtk? ( >=x11-libs/gtk+-2.10 >=gnome-base/libglade-2.6 )
		 pari? ( >=sci-mathematics/pari-2.3.0 )
		 postgres? ( >=virtual/postgresql-base-8.0 )
		 readline? ( >=sys-libs/readline-5.0 )
		 pcre? ( dev-libs/libpcre )
		 svm? ( sci-libs/libsvm )
		 zlib? ( sys-libs/zlib )
		 X? ( new-clx? ( x11-libs/libXpm ) )
		 hyperspec? ( dev-lisp/hyperspec )"
# 		 berkdb? ( sys-libs/db:4.5 )
DEPEND="${RDEPEND} X? ( new-clx? ( x11-misc/imake x11-proto/xextproto ) )"
PDEPEND="dev-lisp/gentoo-init"

PROVIDE="virtual/commonlisp"

enable_modules() {
	[[ $# = 0 ]] && die "${FUNCNAME[0]} must receive at least one argument"
	for m in "$@" ; do
		einfo "enabling module $m"
		myconf="${myconf} --with-module=${m}"
	done
}

BUILDDIR="builddir"

# modules not enabled:
#  * berkdb: must figure out a way to make the configure script pick up the
#            currect version of the library and headers
#  * dirkey: fails to compile, requiring windows.h, possibly wrong #ifdefs
#  * matlab, netica: not in portage
#  * oracle: can't install oracle-instantclient

src_unpack() {
	git_src_unpack
	cd "${S}"

	epatch "${FILESDIR}"/0001-Fix-Linux-threaded-build.patch

	# More than -O1 breaks alpha/ia64
	use alpha || use ia64 && sed -i -e 's/-O2//g' "${S}"/src/makemake.in
}

src_configure() {
	# We need this to build on alpha/ia64
	if use alpha || use ia64; then
		replace-flags -O? -O1
		append-flags '-D NO_MULTIMAP_SHM -D NO_MULTIMAP_FILE -D NO_SINGLEMAP -D NO_TRIVIALMAP'
	fi

	# built-in features
	local myconf="--with-ffcall --with-dynamic-modules"
	if use jit ; then
		myconf="${myconf} --with-jit=lightning"
	fi
	if use threads ; then
		myconf="${myconf} --with-threads=POSIX_THREADS"
	fi

	# default modules
	enable_modules wildcard rawsock
	# optional modules
	use elibc_glibc && enable_modules bindings/glibc
	if use X; then
		if use new-clx; then
			enable_modules clx/new-clx
		else
			enable_modules clx/mit-clx
		fi
	fi
	if use postgres; then
		enable_modules postgresql
		CPPFLAGS="-I $(pg_config --includedir)"
	fi
# 	if use berkdb; then
# 		enable_modules berkley-db
# 		CPPFLAGS="${CPPFLAGS} -I /usr/include/db4.5"
# 	fi
	use dbus && enable_modules dbus
	use fastcgi && enable_modules fastcgi
	use gdbm && enable_modules gdbm
	use gtk && enable_modules gtk2
	use pari && enable_modules pari
	use pcre && enable_modules pcre
	use svm && enable_modules libsvm
	use zlib && enable_modules zlib

	if use hyperspec; then
		CLHSROOT="file:///usr/share/doc/hyperspec/HyperSpec/"
	else
		CLHSROOT="http://www.lispworks.com/reference/HyperSpec/"
	fi

	# configure chokes on --infodir option
	local opts="--prefix=/usr --libdir=/usr/$(get_libdir) \
		$(use_with readline) $(use_with unicode) \
		${myconf} --hyperspec=${CLHSROOT} ${BUILDDIR}"
	einfo configure "${opts}"
	./configure ${opts} || die "./configure failed"

	cd ${BUILDDIR}
	sed -i 's,"vi","nano",g' config.lisp
	IMPNOTES="file://${ROOT%/}/usr/share/doc/${PN}-${PVR}/html/impnotes.html"
	sed -i "s,http://clisp.cons.org/impnotes/,${IMPNOTES},g" config.lisp
}

src_compile() {
	export VARTEXFONTS="${T}"/fonts
	cd ${BUILDDIR}
	# parallel build fails
	emake -j1 || die "emake failed"
}

src_install() {
	pushd ${BUILDDIR}
	make DESTDIR="${D}" prefix=/usr install-bin || die
	doman clisp.1
	dodoc SUMMARY README* NEWS MAGIC.add ANNOUNCE
	chmod a+x "${D}"/usr/$(get_libdir)/clisp-*/clisp-link || die "clisp-link chmod"
	popd
	dohtml doc/impnotes.{css,html} doc/regexp.html doc/clisp.png
	dodoc doc/{editors,CLOS-guide,LISP-tutorial}.txt
}
