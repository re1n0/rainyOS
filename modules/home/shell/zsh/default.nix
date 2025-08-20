{ pkgs, ... }:
let
  shellAliases = import ./aliases.nix;
  zplug = import ./zplug.nix;
in
{
  home.packages = with pkgs; [
    curl
    dig
    wget

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

    grex
    qrtool

    presenterm
  ];

  programs.zsh = {
    enable = true;

    autocd = true;
    enableCompletion = true;

    inherit zplug shellAliases;
  };
}
