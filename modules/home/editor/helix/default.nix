{ pkgs, config, ... }:
let
  languages = import ./languages.nix;
  settings = import ./settings.nix;
  themes = import ./themes.nix config;
in
{
  home.packages = with pkgs; [
    deadnix
    nil
    nixfmt-rfc-style
    statix

    tombi
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    inherit languages settings themes;
  };

  stylix.targets.helix.enable = false;
}
