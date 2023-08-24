# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.20.0
	adler@1.0.2
	aho-corasick@1.0.2
	ammonia@3.3.0
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.3.2
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	anstyle@1.0.1
	anyhow@1.0.72
	assert_cmd@2.0.12
	autocfg@1.1.0
	backtrace@0.3.68
	base64@0.13.1
	base64@0.21.2
	bitflags@1.3.2
	bitflags@2.3.3
	bit-set@0.5.3
	bit-vec@0.6.3
	block-buffer@0.10.4
	bstr@1.6.0
	bumpalo@3.13.0
	byteorder@1.4.3
	bytes@1.4.0
	cc@1.0.79
	cfg-if@1.0.0
	chrono@0.4.26
	clap@4.3.12
	clap_builder@4.3.12
	clap_complete@4.3.2
	clap_lex@0.5.0
	colorchoice@1.0.0
	core-foundation-sys@0.8.4
	cpufeatures@0.2.9
	crossbeam-channel@0.5.8
	crossbeam-utils@0.8.16
	crypto-common@0.1.6
	difflib@0.4.0
	diff@0.1.13
	digest@0.10.7
	doc-comment@0.3.3
	either@1.8.1
	elasticlunr-rs@3.0.2
	env_logger@0.10.0
	errno-dragonfly@0.1.2
	errno@0.3.1
	fastrand@1.9.0
	filetime@0.2.21
	float-cmp@0.9.0
	fnv@1.0.7
	form_urlencoded@1.2.0
	fsevent-sys@4.1.0
	futf@0.1.5
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	generic-array@0.14.7
	getrandom@0.2.10
	gimli@0.27.3
	globset@0.4.11
	h2@0.3.20
	handlebars@4.3.7
	hashbrown@0.12.3
	headers-core@0.2.0
	headers@0.3.8
	hermit-abi@0.3.2
	html5ever@0.26.0
	httparse@1.8.0
	httpdate@1.0.2
	http-body@0.4.5
	http@0.2.9
	humantime@2.1.0
	hyper@0.14.27
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.57
	idna@0.4.0
	ignore@0.4.20
	indexmap@1.9.3
	inotify-sys@0.1.5
	inotify@0.9.6
	instant@0.1.12
	io-lifetimes@1.0.11
	is-terminal@0.4.9
	itertools@0.10.5
	itoa@1.0.9
	js-sys@0.3.64
	kqueue-sys@1.0.3
	kqueue@1.0.7
	lazy_static@1.4.0
	libc@0.2.147
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.3
	lock_api@0.4.10
	log@0.4.19
	mac@0.1.1
	maplit@1.0.2
	markup5ever@0.11.0
	markup5ever_rcdom@0.2.0
	memchr@2.5.0
	mime@0.3.17
	mime_guess@2.0.4
	miniz_oxide@0.7.1
	mio@0.8.8
	new_debug_unreachable@1.0.4
	normalize-line-endings@0.3.0
	normpath@1.1.1
	notify-debouncer-mini@0.3.0
	notify@6.0.1
	num-traits@0.2.15
	num_cpus@1.16.0
	object@0.31.1
	once_cell@1.18.0
	opener@0.6.1
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	percent-encoding@2.3.0
	pest@2.7.0
	pest_derive@2.7.0
	pest_generator@2.7.0
	pest_meta@2.7.0
	phf@0.10.1
	phf_codegen@0.10.0
	phf_generator@0.10.0
	phf_shared@0.10.0
	pin-project-internal@1.1.2
	pin-project-lite@0.2.10
	pin-project@1.1.2
	pin-utils@0.1.0
	ppv-lite86@0.2.17
	precomputed-hash@0.1.1
	predicates-core@1.0.6
	predicates-tree@1.0.9
	predicates@3.0.3
	pretty_assertions@1.4.0
	proc-macro2@1.0.66
	pulldown-cmark@0.9.3
	quote@1.0.31
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	regex-automata@0.3.3
	regex-syntax@0.7.4
	regex@1.9.1
	rustc-demangle@0.1.23
	rustix@0.37.23
	rustix@0.38.4
	rustls-pemfile@1.0.3
	ryu@1.0.15
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.1.0
	select@0.6.0
	semver@1.0.18
	serde@1.0.171
	serde_derive@1.0.171
	serde_json@1.0.103
	serde_urlencoded@0.7.1
	sha1@0.10.5
	sha2@0.10.7
	shlex@1.1.0
	siphasher@0.3.10
	slab@0.4.8
	smallvec@1.11.0
	socket2@0.4.9
	string_cache@0.8.7
	string_cache_codegen@0.5.2
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.26
	tempfile@3.6.0
	tendril@0.4.3
	termcolor@1.2.0
	terminal_size@0.2.6
	termtree@0.4.1
	thiserror-impl@1.0.43
	thiserror@1.0.43
	thread_local@1.1.7
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-macros@2.1.0
	tokio-stream@0.1.14
	tokio-tungstenite@0.18.0
	tokio-util@0.7.8
	tokio@1.29.1
	toml@0.5.11
	topological-sort@0.2.2
	tower-service@0.3.2
	tracing-core@0.1.31
	tracing@0.1.37
	try-lock@0.2.4
	tungstenite@0.18.0
	typenum@1.16.0
	ucd-trie@0.1.6
	unicase@2.6.0
	unicode-bidi@0.3.13
	unicode-ident@1.0.11
	unicode-normalization@0.1.22
	url@2.4.0
	utf8parse@0.2.1
	utf-8@0.7.6
	version_check@0.9.4
	wait-timeout@0.2.0
	walkdir@2.3.3
	want@0.3.1
	warp@0.3.5
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-targets@0.42.2
	windows-targets@0.48.1
	windows@0.48.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.0
	xml5ever@0.17.0
	yansi@0.5.1
"
inherit cargo toolchain-funcs

DESCRIPTION="Create a book from markdown files"
HOMEPAGE="https://rust-lang.github.io/mdBook/"
SRC_URI="
	https://github.com/rust-lang/mdBook/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${P/b/B}"

# CC-BY-4.0/OFL-1.1: embeds fonts inside the executable
LICENSE="MPL-2.0 CC-BY-4.0 OFL-1.1"
LICENSE+="
	Apache-2.0 BSD ISC MIT Unicode-DFS-2016
	|| ( Artistic-2 CC0-1.0 )
" # crates
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
IUSE="doc"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	cargo_src_compile

	if use doc; then
		if tc-is-cross-compiler; then
			ewarn "html docs were skipped due to cross-compilation"
		else
			target/$(usex debug{,} release)/${PN} build -d html guide || die
		fi
	fi
}

src_install() {
	cargo_src_install

	dodoc CHANGELOG.md README.md
	use doc && ! tc-is-cross-compiler && dodoc -r guide/html
}
