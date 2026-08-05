# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"

CRATES="
aho-corasick@1.1.4
android_system_properties@0.1.5
anstream@0.6.21
anstyle-parse@0.2.7
anstyle-query@1.1.5
anstyle-wincon@3.0.11
anstyle@1.0.13
anyhow@1.0.100
async-trait@0.1.89
atomic-waker@1.1.2
autocfg@1.5.0
aws-lc-rs@1.15.4
aws-lc-sys@0.37.0
axum-core@0.5.6
axum@0.8.8
base64@0.22.1
bindgen@0.72.1
bitflags@2.10.0
block-buffer@0.10.4
bumpalo@3.19.1
bytes@1.11.0
cc@1.2.55
cesu8@1.1.0
cexpr@0.6.0
cfg-if@1.0.4
cfg_aliases@0.2.1
chrono@0.4.43
clang-sys@1.8.1
clap@4.5.56
clap_builder@4.5.56
clap_derive@4.5.55
clap_lex@0.7.7
cmake@0.1.57
colorchoice@1.0.4
colored@3.1.1
combine@4.6.7
console@0.16.2
core-foundation-sys@0.8.7
core-foundation@0.10.1
core-foundation@0.9.4
cpufeatures@0.2.17
crypto-common@0.1.7
darling@0.23.0
darling_core@0.23.0
darling_macro@0.23.0
digest@0.10.7
dirs-sys@0.5.0
dirs@6.0.0
displaydoc@0.2.5
dunce@1.0.5
dyn-clone@1.0.20
either@1.15.0
encode_unicode@1.0.0
encoding_rs@0.8.35
enumflags2@0.7.12
enumflags2_derive@0.7.12
equivalent@1.0.2
errno@0.3.14
fallible-iterator@0.3.0
fallible-streaming-iterator@0.1.9
find-msvc-tools@0.1.9
find_cuda_helper@0.2.0
fnv@1.0.7
foldhash@0.2.0
form_urlencoded@1.2.2
fs_extra@1.3.0
futures-channel@0.3.31
futures-core@0.3.31
futures-executor@0.3.31
futures-io@0.3.31
futures-macro@0.3.31
futures-sink@0.3.31
futures-task@0.3.31
futures-util@0.3.31
futures@0.3.31
fuzzy-matcher@0.3.7
generic-array@0.14.7
getrandom@0.2.17
getrandom@0.3.4
glob@0.3.3
h2@0.4.13
hashbrown@0.16.1
hashlink@0.11.0
heck@0.5.0
http-body-util@0.1.3
http-body@1.0.1
http@1.4.0
httparse@1.10.1
httpdate@1.0.3
hyper-rustls@0.27.7
hyper-util@0.1.19
hyper@1.8.1
iana-time-zone-haiku@0.1.2
iana-time-zone@0.1.65
icu_collections@2.1.1
icu_locale_core@2.1.1
icu_normalizer@2.1.1
icu_normalizer_data@2.1.1
icu_properties@2.1.2
icu_properties_data@2.1.2
icu_provider@2.1.1
ident_case@1.0.1
idna@1.1.0
idna_adapter@1.2.1
indexmap@2.13.0
indicatif@0.18.3
ipnet@2.11.0
iri-string@0.7.10
is_terminal_polyfill@1.70.2
itertools@0.13.0
itoa@1.0.17
jni-sys@0.3.0
jni@0.21.1
jobserver@0.1.34
js-sys@0.3.85
lazy_static@1.5.0
libc@0.2.180
libloading@0.8.9
libredox@0.1.12
libsqlite3-sys@0.36.0
litemap@0.8.1
llama-cpp-2@0.1.132
llama-cpp-sys-2@0.1.132
log@0.4.29
lru-slab@0.1.2
matchers@0.2.0
matchit@0.8.4
memchr@2.7.6
mime@0.3.17
minimal-lexical@0.2.1
mio@1.1.1
nom@7.1.3
nu-ansi-term@0.50.3
num-traits@0.2.19
once_cell@1.21.3
once_cell_polyfill@1.70.2
openssl-probe@0.2.1
option-ext@0.2.0
pastey@0.2.1
percent-encoding@2.3.2
pin-project-lite@0.2.16
pin-utils@0.1.0
pkg-config@0.3.32
portable-atomic@1.13.1
potential_utf@0.1.4
ppv-lite86@0.2.21
prettyplease@0.2.37
proc-macro2@1.0.106
quinn-proto@0.11.13
quinn-udp@0.5.14
quinn@0.11.9
quote@1.0.44
r-efi@5.3.0
rand@0.9.2
rand_chacha@0.9.0
rand_core@0.9.5
redox_users@0.5.2
ref-cast-impl@1.0.25
ref-cast@1.0.25
regex-automata@0.4.13
regex-syntax@0.8.8
regex@1.12.2
reqwest@0.13.1
ring@0.17.14
rmcp-macros@0.14.0
rmcp@0.14.0
rsqlite-vfs@0.1.0
rusqlite@0.38.0
rustc-hash@2.1.1
rustls-native-certs@0.8.3
rustls-pki-types@1.14.0
rustls-platform-verifier-android@0.1.1
rustls-platform-verifier@0.6.2
rustls-webpki@0.103.9
rustls@0.23.36
rustversion@1.0.22
ryu@1.0.22
same-file@1.0.6
schannel@0.1.28
schemars@1.2.1
schemars_derive@1.2.1
security-framework-sys@2.15.0
security-framework@3.5.1
serde@1.0.228
serde_core@1.0.228
serde_derive@1.0.228
serde_derive_internals@0.29.1
serde_json@1.0.149
serde_path_to_error@0.1.20
serde_urlencoded@0.7.1
serde_yaml@0.9.34+deprecated
sha2@0.10.9
sharded-slab@0.1.7
shlex@1.3.0
signal-hook-registry@1.4.8
slab@0.4.12
smallvec@1.15.1
socket2@0.6.2
sqlite-wasm-rs@0.5.2
sse-stream@0.2.1
stable_deref_trait@1.2.1
strsim@0.11.1
subtle@2.6.1
syn@2.0.114
sync_wrapper@1.0.2
synstructure@0.13.2
system-configuration-sys@0.6.0
system-configuration@0.6.1
thiserror-impl@1.0.69
thiserror-impl@2.0.18
thiserror@1.0.69
thiserror@2.0.18
thread_local@1.1.9
tinystr@0.8.2
tinyvec@1.10.0
tinyvec_macros@0.1.1
tokio-macros@2.6.0
tokio-rustls@0.26.4
tokio-stream@0.1.18
tokio-util@0.7.18
tokio@1.49.0
tower-http@0.6.8
tower-layer@0.3.3
tower-service@0.3.3
tower@0.5.3
tracing-attributes@0.1.31
tracing-core@0.1.36
tracing-log@0.2.0
tracing-subscriber@0.3.22
tracing@0.1.44
try-lock@0.2.5
typenum@1.19.0
unicode-ident@1.0.22
unicode-width@0.2.2
unit-prefix@0.5.2
unsafe-libyaml@0.2.11
untrusted@0.9.0
url@2.5.8
utf8_iter@1.0.4
utf8parse@0.2.2
uuid@1.20.0
valuable@0.1.1
vcpkg@0.2.15
version_check@0.9.5
walkdir@2.5.0
want@0.3.1
wasi@0.11.1+wasi-snapshot-preview1
wasip2@1.0.2+wasi-0.2.9
wasm-bindgen-futures@0.4.58
wasm-bindgen-macro-support@0.2.108
wasm-bindgen-macro@0.2.108
wasm-bindgen-shared@0.2.108
wasm-bindgen@0.2.108
web-sys@0.3.85
web-time@1.1.0
webpki-root-certs@1.0.5
winapi-util@0.1.11
windows-core@0.62.2
windows-implement@0.60.2
windows-interface@0.59.3
windows-link@0.2.1
windows-registry@0.6.1
windows-result@0.4.1
windows-strings@0.5.1
windows-sys@0.45.0
windows-sys@0.52.0
windows-sys@0.60.2
windows-sys@0.61.2
windows-targets@0.42.2
windows-targets@0.52.6
windows-targets@0.53.5
windows_aarch64_gnullvm@0.42.2
windows_aarch64_gnullvm@0.52.6
windows_aarch64_gnullvm@0.53.1
windows_aarch64_msvc@0.42.2
windows_aarch64_msvc@0.52.6
windows_aarch64_msvc@0.53.1
windows_i686_gnu@0.42.2
windows_i686_gnu@0.52.6
windows_i686_gnu@0.53.1
windows_i686_gnullvm@0.52.6
windows_i686_gnullvm@0.53.1
windows_i686_msvc@0.42.2
windows_i686_msvc@0.52.6
windows_i686_msvc@0.53.1
windows_x86_64_gnu@0.42.2
windows_x86_64_gnu@0.52.6
windows_x86_64_gnu@0.53.1
windows_x86_64_gnullvm@0.42.2
windows_x86_64_gnullvm@0.52.6
windows_x86_64_gnullvm@0.53.1
windows_x86_64_msvc@0.42.2
windows_x86_64_msvc@0.52.6
windows_x86_64_msvc@0.53.1
wit-bindgen@0.51.0
writeable@0.6.2
yoke-derive@0.8.1
yoke@0.8.1
zerocopy-derive@0.8.37
zerocopy@0.8.37
zerofrom-derive@0.1.6
zerofrom@0.1.6
zeroize@1.8.2
zerotrie@0.2.3
zerovec-derive@0.11.2
zerovec@0.11.5
zmij@1.0.19
"

inherit cargo

DESCRIPTION="Local search engine and MCP server for AI agents"
HOMEPAGE="https://github.com/qntx-labs/qmd"
SRC_URI="
	https://github.com/qntx-labs/qmd/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	${CARGO_CRATE_URIS}
	https://huggingface.co/ggml-org/embeddinggemma-300M-GGUF/resolve/0f741b5a6585bd53aeb15cd1372c56f2a0f65e12/embeddinggemma-300M-Q8_0.gguf
		-> ${P}-embeddinggemma-300M-Q8_0.gguf
"

LICENSE="MIT Apache-2.0 Gemma"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="acct-user/qmd"
BDEPEND="
	dev-build/cmake
	llvm-core/clang
"

PATCHES=( "${FILESDIR}"/${P}-http-and-model-path.patch )

src_compile() {
	cargo build --release --locked -p qmd-cli -p qmd-mcp || die
}

src_test() {
	cargo test --release --locked -p qmd -p qmd-mcp || die
}

src_install() {
	exeinto /usr/libexec/qmd
	doexe "$(cargo_target_dir)"/qmd
	doexe "$(cargo_target_dir)"/qmd-mcp

	dobin "${FILESDIR}"/qmd "${FILESDIR}"/qmd-mcp

	insinto /var/lib/qmd/models
	newins "${DISTDIR}"/${P}-embeddinggemma-300M-Q8_0.gguf \
		embeddinggemma-300M-Q8_0.gguf

	keepdir /var/lib/qmd/config
	fowners -R qmd:qmd /var/lib/qmd
	fperms 0770 /var/lib/qmd /var/lib/qmd/config /var/lib/qmd/models
	fperms 0440 /var/lib/qmd/models/embeddinggemma-300M-Q8_0.gguf

	dodoc README.md
	dodoc "${FILESDIR}"/GEMMA-NOTICE
}

pkg_postinst() {
	elog "QMD shared state is stored below /var/lib/qmd."
	elog "Run administrative CLI commands as qmd, for example:"
	elog "  doas -u qmd qmd status"
	elog "Use app-misc/qmd-mcp to expose this index to MCP clients over HTTP."
}
