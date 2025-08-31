{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    dig
    wget

    e2fsprogs
    btrfs-progs
    ntfs3g

    fd

    tailspin
    eza
    du-dust

    ffmpeg

    killall

    lshw
    pciutils
    usbutils

    rsclock
    astroterm
    tukai

    tokei

    asak

    yt-dlp
    ytmdl

    wireguard-tools

    nix-hash-git
    nix-output-monitor
    nix-update
    nixpkgs-review

    grex
    qrtool

    presenterm
  ];
}
