{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    dig
    wget

    e2fsprogs
    btrfs-progs
    ntfs3g

    ripgrep

    tailspin
    dust
    file
    delta
    hexyl

    ffmpeg-full

    killall

    lshw
    pciutils
    usbutils

    gopass
    gopass-hibp

    rsclock
    astroterm
    tukai

    tokei

    asak

    mcat

    procs

    yt-dlp
    ytmdl

    nix-tree
    nix-output-monitor
    nixpkgs-review
    nix-update
    nurl
    nix-init

    grex
    qrtool

    asciinema
    asciinema-agg
    presenterm
  ];
}
