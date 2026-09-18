# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Knowledge base for plain text Markdown files"
HOMEPAGE="https://obsidian.md/"
APPIMAGE="Obsidian-${PV}.AppImage"
SRC_URI="https://github.com/obsidianmd/obsidian-releases/releases/download/v${PV}/${APPIMAGE}"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	virtual/zlib
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_DT_NEEDED="*"
QA_PREBUILT="opt/${PN}/*"
QA_SONAME="*"

src_unpack() {
	mkdir -p "${S}" || die
	cp "${DISTDIR}/${APPIMAGE}" "${S}/${APPIMAGE}" || die

	cd "${S}" || die
	chmod +x "${APPIMAGE}" || die
	"./${APPIMAGE}" --appimage-extract || die
}

src_prepare() {
	default

	find "${S}/squashfs-root" -type d -exec chmod a+rx {} + || die
	find "${S}/squashfs-root" -type f -exec chmod a+r {} + || die
	chmod +x "${S}/squashfs-root/obsidian" || die
}

src_install() {
	cd "${S}/squashfs-root" || die

	if [[ -d usr/share/icons ]]; then
		insinto /usr/share/icons
		doins -r usr/share/icons/*
	fi

	local desktop_file
	for desktop_file in usr/share/applications/*.desktop *.desktop; do
		if [[ -f ${desktop_file} ]]; then
			sed -i \
				-e 's|^Exec=.*|Exec=obsidian %U|' \
				-e 's|^Icon=.*|Icon=obsidian|' \
				-e 's|^Comment=.*|Comment=Knowledge base|' \
				"${desktop_file}" || die
			domenu "${desktop_file}"
			break
		fi
	done

	rm -f .DirIcon obsidian.png || die
	rm -rf usr/share || die

	local apphome="/opt/${PN}"
	dodir "${apphome}"
	cp -a . "${ED}${apphome}/" || die
	fperms 0755 "${apphome}/AppRun" "${apphome}/obsidian" "${apphome}/obsidian-cli"
	if [[ -f "${ED}${apphome}/chrome-sandbox" ]]; then
		fperms 4755 "${apphome}/chrome-sandbox"
	fi

	dosym -r "${apphome}/AppRun" "/usr/bin/${PN}"
	dosym -r "${apphome}/obsidian-cli" "/usr/bin/obsidian-cli"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
