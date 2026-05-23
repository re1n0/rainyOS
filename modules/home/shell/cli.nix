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
    ripgrep

    tailspin
    eza
    dust
    file
    delta
    hexyl

    ffmpeg-full

    killall

    lshw
    pciutils
    usbutils

    rsclock
    astroterm
    tukai

    tokei

    asak

    chafa

    procs

    sheetui

    yt-dlp
    ytmdl

    wireguard-tools

    nix-tree
    nix-output-monitor
    nixpkgs-review
    nvfetcher

    grex
    qrtool

    asciinema
    asciinema-agg
    presenterm
  ];
}
