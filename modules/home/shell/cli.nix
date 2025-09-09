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

    nix-tree
    nix-hash-git
    nix-hash-url
    nix-output-monitor
    nix-update
    nixpkgs-fmt
    nixpkgs-review

    grex
    qrtool

    asciinema_3
    asciinema-agg
    presenterm

    sysinfo
  ];
}
