# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson toolchain-funcs

DESCRIPTION="A dynamic tiling Wayland compositor that doesn't sacrifice on its looks"
HOMEPAGE="https://github.com/hyprwm/Hyprland"

SRC_URI="https://github.com/hyprwm/${PN^}/releases/download/v${PV}/source-v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-source"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
IUSE="X legacy-renderer systemd video_cards_nvidia"

# bundled wlroots has the following dependency string according to included headers.
# wlroots[drm,gles2-renderer,libinput,x11-backend?,X?]
# enable x11-backend with X and vice versa
WLROOTS_RDEPEND="
	>=dev-libs/libinput-1.14.0:=
	dev-libs/libliftoff
	>=dev-libs/wayland-1.22
	media-libs/libdisplay-info
	media-libs/libglvnd
	media-libs/mesa[egl(+),gles2]
	sys-apps/hwdata:=
	sys-auth/seatd:=
	>=x11-libs/libdrm-2.4.114
	x11-libs/libxkbcommon
	>=x11-libs/pixman-0.42.0
	virtual/libudev:=
	X? (
		x11-base/xwayland
		x11-libs/libxcb:0=
		x11-libs/xcb-util-renderutil
		x11-libs/xcb-util-wm
	)
"
WLROOTS_DEPEND="
	>=dev-libs/wayland-protocols-1.32
"
WLROOTS_BDEPEND="
	dev-util/glslang
	dev-util/wayland-scanner
"

RDEPEND="
	${WLROOTS_RDEPEND}
	dev-libs/glib:2
	dev-libs/libinput
	dev-libs/wayland
	media-libs/libglvnd
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/pixman
	X? (
		x11-libs/libxcb:0=
	)
"
DEPEND="
	${RDEPEND}
	${WLROOTS_DEPEND}
	dev-libs/hyprland-protocols
	>=dev-libs/wayland-protocols-1.25
"
BDEPEND="
	${WLROOTS_BDEPEND}
	|| ( >=sys-devel/gcc-13:* >=sys-devel/clang-16:* )
	app-misc/jq
	dev-util/cmake
	dev-util/wayland-scanner
	dev-vcs/git
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/hyprland-0.30.0-no-wlroots-automagic-r1.patch"
	"${FILESDIR}/hyprland-0.30.0-3400-fix-build.patch"
)

pkg_setup() {
	[[ ${MERGE_TYPE} == binary ]] && return

	if tc-is-gcc && ver_test $(gcc-version) -lt 13 ; then
		eerror "Hyprland requires >=sys-devel/gcc-13 to build"
		eerror "Please upgrade GCC: emerge -v1 sys-devel/gcc"
		die "GCC version is too old to compile Hyprland!"
	elif tc-is-clang && ver_test $(clang-version) -lt 16 ; then
		eerror "Hyprland requires >=sys-devel/clang-16 to build"
		eerror "Please upgrade Clang: emerge -v1 sys-devel/clang"
		die "Clang version is too old to compile Hyprland!"
	fi
}

src_prepare() {
	if use video_cards_nvidia; then
		cd "${S}/subprojects/wlroots" || die
		eapply "${S}/nix/patches/wlroots-nvidia.patch"
		cd "${S}" || die
	fi

	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature legacy-renderer legacy_renderer)
		$(meson_feature X xwayland)
		$(meson_feature systemd)
	)

	meson_src_configure
}

src_install() {
	meson_src_install --skip-subprojects wlroots
}
