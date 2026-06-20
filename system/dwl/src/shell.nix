{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
        gnumake
        clang
        pkg-config
        wayland-scanner
        wayland-protocols
        wayland
        libxkbcommon
        pixman
        wlroots_0_19
        xwayland
        libinput
        xcb-proto
        libxcb-util
        libxcb-wm
    ];
}
